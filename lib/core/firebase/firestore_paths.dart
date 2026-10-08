/// مسارات Firestore المركزية — ممنوع كتابة مسارات collections/documents
/// كنصوص مباشرة في أي طبقة (قاعدة: لا hardcoded strings للمسارات).
class FirestorePaths {
  FirestorePaths._();

  static const String users = 'users';

  static String userDoc(String uid) => '$users/$uid';

  static String userTasks(String uid) => '${userDoc(uid)}/tasks';

  static String userSessions(String uid) => '${userDoc(uid)}/sessions';

  static String userSchedule(String uid) => '${userDoc(uid)}/schedule';

  static String userSubjects(String uid) => '${userDoc(uid)}/subjects';
}
