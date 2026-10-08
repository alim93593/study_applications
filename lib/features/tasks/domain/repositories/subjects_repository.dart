import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

/// عقد مواد Subject Area — القراءة ستريم والكتابة Either.
abstract class SubjectsRepository {
  Stream<List<String>> watchSubjects();

  Future<Either<Failure, void>> addSubject(String name);
}
