import 'package:flutter_sem_2/services/auth/auth_exception.dart';
import 'package:flutter_sem_2/services/auth/auth_provider.dart';
import 'package:flutter_sem_2/services/auth/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Mock Authentication',
    () {
      final provider = MockAuthProvider();
      test('Shuld not be initialized to begin with', () {
        expect(provider._isinitialized, false);
      });
      test('Cannot not logout if not Initialized', () {
        expect(
          provider.logout(),
          throwsA(const TypeMatcher<NotInitializedException>()),
        );
      });
      test('Should be initialized', () async {
        await provider.initialize();
        expect(provider._isinitialized, true);
      });

      test('user should be null upon initialization', () {
        expect(provider.currentuser, null);
      });
      test(
        'Should be able to initialize in les than 2 seconds',
        () async {
          await provider.initialize();
          expect(provider._isinitialized, true);
        },
        timeout: const Timeout(Duration(seconds: 3)),
      );

      test('Create user should delegate to login function', () async {
        final BadEmailUser = provider.createuser(
          email: 'foo@bar.com',
          password: 'anypassword',
        );
        expect(
          BadEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()),
        );
        final BadUSerPassword = provider.createuser(
          email: 'deadmanwalking@gmail.com',
          password: 'foobarbaz',
        );
        expect(
          BadUSerPassword,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()),
        );

        final user = await provider.createuser(
          email: 'aryanchoudhary@gmail.com',
          password: 'AryanChoudhary',
        );
        expect(provider.currentuser, user);
        expect(user.isEmailVerified, false);
      });

      test('loged in user should be able to verify', () {
        provider.sendEmailVerification();
        final user = provider.currentuser;
        expect(user, isNotNull);
        expect(user!.isEmailVerified, true);
      });

      test('Should be able to log out and log in again', () async {
        await provider.logout();
        await provider.login(
          email: 'email',
          password: 'password',
        );
        final user = provider.currentuser;
        expect(user, isNotNull);
      });
    },
  );
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isinitialized = false;
  bool get isinitialized => _isinitialized;
  @override
  Future<AuthUser> createuser({
    required String email,
    required String password,
  }) async {
    if (!isinitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 2));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentuser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _isinitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!isinitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobarbaz') throw WrongPasswordAuthException();
    const user = AuthUser(
      isEmailVerified: false,
      email: '',
      id: 'my_id',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isinitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 2));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isinitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      email: '',
      id: 'my_id',
    );
    _user = newUser;
  }
  
  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();        
  }
}
