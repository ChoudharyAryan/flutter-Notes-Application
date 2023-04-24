import 'package:flutter_sem_2/services/auth/auth_provider.dart';
import 'package:flutter_sem_2/services/auth/auth_user.dart';
import 'package:flutter_sem_2/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FireBaseAuthProvider());

  @override
  Future<AuthUser> createuser({
    required String email,
    required String password,
  }) =>
      provider.createuser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentuser => provider.currentuser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );
  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();
}
