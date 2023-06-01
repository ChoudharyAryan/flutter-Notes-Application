import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sem_2/services/auth/auth_provider.dart';
import 'package:flutter_sem_2/services/auth/auth_user.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    //SENDING EMAIL VERIFICATION
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    //REGISTERING
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createuser(
            email: email,
            password: password,
          );
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(e));
        }
      },
    );
    // INITIALIZING
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentuser;
      if (user == null) {
        emit(
          const AuthStateLoggedOut(null, false)
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    //LOGING IN
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(null, true));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.login(
          email: email,
          password: password,
        );
        if(!user.isEmailVerified){
          emit(const AuthStateLoggedOut(null, false));
          emit(const AuthStateNeedsVerification());
        }else{
          emit(const AuthStateLoggedOut(null, false));
          emit(AuthStateLoggedIn(user));                  
        }                
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e, false));
      }
    });
    //LOGING OUT

    on<AuthEventLogOut>((event, emit) async {
      try{
        await provider.logout();
        emit(const AuthStateLoggedOut(null, false));
      } on Exception catch(e){
        emit(AuthStateLoggedOut(e, false));
      }
    });
  }
}
