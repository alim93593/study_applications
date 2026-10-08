import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../domain/entities/task_entity.dart';
import '../models/task_model.dart';

abstract class TasksRemoteDataSource {
  Stream<List<TaskEntity>> watchTasks();

  Future<void> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> toggleComplete(String id, {required bool completed});

  Future<void> deleteTask(String id);
}

/// تنفيذ Firestore لمسار userTasks عبر FirebaseService.
/// Why (الدستور): **صفر try-catch هنا** + **صفر مسارات hardcoded** —
/// الـ DataSource يرفع الخطأ كما هو والمسارات من FirestorePaths.
class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final FirebaseService _firebase;

  TasksRemoteDataSourceImpl({required FirebaseService firebase})
    : _firebase = firebase;

  String? get _path {
    final uid = _firebase.auth.currentUser?.uid;
    return uid == null ? null : FirestorePaths.userTasks(uid);
  }

  @override
  Stream<List<TaskEntity>> watchTasks() {
    final path = _path;
    if (path == null) {
      return Stream<List<TaskEntity>>.value(const []);
    }
    return _firebase.firestore
        .getCollectionStream(collection: path)
        .map<List<TaskEntity>>(TaskModel.fromSnapshot);
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final path = _path;
    if (path == null) {
      return;
    }
    await _firebase.firestore.addDocument(collection: path, data: task.toMap());
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final path = _path;
    if (path == null) {
      return;
    }
    await _firebase.firestore.updateDocument(
      collection: path,
      documentId: task.id,
      data: task.toMap(),
    );
  }

  @override
  Future<void> toggleComplete(String id, {required bool completed}) async {
    final path = _path;
    if (path == null) {
      return;
    }
    await _firebase.firestore.updateDocument(
      collection: path,
      documentId: id,
      data: {
        'status': completed
            ? TaskStatus.completed.name
            : TaskStatus.pending.name,
        'completedAt': completed ? Timestamp.fromDate(DateTime.now()) : null,
      },
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    final path = _path;
    if (path == null) {
      return;
    }
    await _firebase.firestore.deleteDocument(collection: path, documentId: id);
  }
}
