/// Translation keys for error/failure messages (auth, network, storage).
/// Why: raw 'key' literals are banned — every key lives here.
/// Displayed via .tr() at the UI layer; data layer only carries the key.
abstract class ErrorStrings {
  ErrorStrings._();

  static const errorEmailInUse = 'error_email_in_use';
  static const errorWrongPassword = 'error_wrong_password';
  static const errorUserNotFound = 'error_user_not_found';
  static const errorWeakPassword = 'error_weak_password';
  static const errorInvalidEmail = 'error_invalid_email';
  static const errorUserDisabled = 'error_user_disabled';
  static const errorOperationNotAllowed = 'error_operation_not_allowed';
  static const errorTooManyRequests = 'error_too_many_requests';
  static const errorNetwork = 'error_network';
  static const errorUnknown = 'error_unknown';
  static const errorSignOutFailed = 'error_sign_out_failed';
  static const errorResetPasswordFailed = 'error_reset_password_failed';
  static const errorSaveUserFailed = 'error_save_user_failed';
  static const errorGetUserFailed = 'error_get_user_failed';
  static const errorUpdateUserFailed = 'error_update_user_failed';
  static const errorGetCurrentUserFailed = 'error_get_current_user_failed';
  static const errorGetProfileFailed = 'error_get_profile_failed';
  static const errorUpdateProfileFailed = 'error_update_profile_failed';
}
