import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/localization/error_strings.dart';

/// تحويل أكواد أخطاء Firebase Auth إلى AuthException الموحّد في طبقة الـ DataSources.
/// Why: استخرجناه من ملف الـ impl عشان يفضل كل ملف تحت 100 سطر.
/// الرسائل مفاتيح ترجمة — العرض يتم عبر .tr() في طبقة الواجهات.
AuthException mapFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return AuthException(
        message: ErrorStrings.errorUserNotFound,
        statusCode: 404,
      );
    case 'wrong-password':
      return AuthException(
        message: ErrorStrings.errorWrongPassword,
        statusCode: 401,
      );
    case 'email-already-in-use':
      return AuthException(
        message: ErrorStrings.errorEmailInUse,
        statusCode: 400,
      );
    case 'weak-password':
      return AuthException(
        message: ErrorStrings.errorWeakPassword,
        statusCode: 400,
      );
    case 'invalid-email':
      return AuthException(
        message: ErrorStrings.errorInvalidEmail,
        statusCode: 400,
      );
    case 'user-disabled':
      return AuthException(
        message: ErrorStrings.errorUserDisabled,
        statusCode: 403,
      );
    case 'operation-not-allowed':
      return AuthException(
        message: ErrorStrings.errorOperationNotAllowed,
        statusCode: 403,
      );
    case 'too-many-requests':
      return AuthException(
        message: ErrorStrings.errorTooManyRequests,
        statusCode: 429,
      );
    case 'network-request-failed':
      return AuthException(
        message: ErrorStrings.errorNetwork,
        statusCode: 503,
      );
    default:
      return AuthException(
        message: ErrorStrings.errorUnknown,
        statusCode: 500,
      );
  }
}

/// تحويل أي خطأ من استدعاءات Firebase — تُستدعى من المستودعات فقط.
/// Why: المستودع لا يستورد firebase_auth (عزل المكتبات) ولا يكتب try-catch
/// في الـ DataSource (AGENTS-8) — يمرّر الخطأ الخام هنا ويأخذ AuthException.
/// fallbackKey: رسالة أخطاء غير Firebase (بدون status code).
AuthException mapAuthCallError(Object e, {String? fallbackKey}) {
  if (e is FirebaseAuthException) return mapFirebaseAuthException(e);
  if (e is AuthException) return e;
  if (fallbackKey != null) return AuthException(message: fallbackKey);
  return AuthException(
    message: ErrorStrings.errorUnknown,
    statusCode: 500,
  );
}
