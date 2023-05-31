import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/auth_exception.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_sem_2/utilities/dialogs/error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
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
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                context.read<AuthBloc>().add(
                      AuthEventLogIn(
                        email,
                        password,
                      ),
                    );
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'user not found',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'invalid email',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'wrong password',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Aunthentication Error',
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('not Registered yet?Register now')),
        ],
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