import 'package:bloc/bloc.dart';
import 'package:flutter_sem_2/services/auth/auth_provider.dart';
import 'package:flutter_sem_2/services/auth/auth_user.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // INITIALIZING
    on<AuthEventInitialize>((event, emit) async{
      await provider.initialize();
      final user = provider.currentuser;
      if(user == null){
        emit(const AuthStateLoggedOut());
      }else if(!user.isEmailVerified){
        emit(const AuthStateNeedsVerification());
      }else{
        emit(AuthStateLoggedIn(user));
      }
    });
    //LOGING IN
    on<AuthEventLogIn>((event , emit) async {
      emit(const AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try{
        final user = await provider.login
        (email: email,
        password: password,
        );
        emit(AuthStateLoggedIn(user));
      } on Exception catch(e){
        emit(AuthStateLoginFailure(e));
      }
    });
    //LOGING OUT
    
    on<AuthEventLogOut>((event , emit) async {      
      try{
        emit(const AuthStateLoading());
        await provider.logout();
        emit(const AuthStateLoggedOut());        
      } on Exception catch(e){
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
