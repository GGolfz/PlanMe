class AuthenicateException implements Exception {
  final String _emailError;
  final String _passwordError;
  AuthenicateException(this._emailError, this._passwordError);
  String get emailError {
    return this._emailError;
  }

  String get passwordError {
    return this._passwordError;
  }
}
