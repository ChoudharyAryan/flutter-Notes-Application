import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/auth_exception.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_sem_2/utilities/dialogs/error_dialog.dart';
import 'package:flutter_sem_2/utilities/dialogs/loading_dialog.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final AnimationController _controller;

  

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 5));    
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _controller.dispose();
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18))),
        centerTitle: true,
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text('Log in to your account to interact with and create notes!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
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
                    Container(
                      child: Lottie.network(
                        'https://assets3.lottiefiles.com/packages/lf20_p7ml1rhe.json', 
                        reverse: true,                    
                        )
                    )                        
              ],
            ),
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