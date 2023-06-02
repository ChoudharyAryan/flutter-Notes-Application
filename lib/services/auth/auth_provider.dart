import 'package:flutter_sem_2/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentuser;
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createuser({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
