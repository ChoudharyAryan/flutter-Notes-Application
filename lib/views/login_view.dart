import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/auth_exception.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_sem_2/utilities/dialogs/error_dialog.dart';
import 'package:flutter_sem_2/utilities/dialogs/loading_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {          
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              'Cannot find a user with the entered credentials!',
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Log in to your account to interact with and create notes!',
              style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your e-mail ',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                obscuringCharacter: '-',
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'enter your password',
                ),
              ),
              CupertinoButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogIn(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text('Login'),
              ),
              CupertinoButton(child: const Text('Reset password'), onPressed:(){
                context.read<AuthBloc>().add(const AuthEventForgotPassword());
              }), 
              CupertinoButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventShouldRegister());
                  },
                  child: const Text('Not registered yet?Register now')),              
            ],
          ),
        ),
      ),
    );
  }
}


// await AuthService.firebase().login(
//                   email: email,
//                   password: password,
//                 );
//                 final user = AuthService.firebase().currentuser;
//                 if (user?.isEmailVerified ?? false) {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     notesRoute,
//                     (route) => false,
//                   );
//                 } else {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     verifyEmailRoute,
//                     (route) => false,
//                   );
//                 }