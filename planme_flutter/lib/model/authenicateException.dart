class AuthenicateException implements Exception {
  final String _emailError;
  final String _passwordError;
  final String message;
  AuthenicateException(this._emailError, this._passwordError, this.message);
  String get emailError {
    return this._emailError;
  }

  String get passwordError {
    return this._passwordError;
  }

  @override
  String toString() {
    return this.message;
  }
}
