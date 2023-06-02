import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sem_2/services/auth/auth_exception.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_sem_2/utilities/dialogs/error_dialog.dart';
import 'package:flutter_sem_2/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context,state)async {
        if(state is AuthStateForgotPassword){
          if(state.hasSentEmail){
            _controller.clear();
            await showPasswordResetEmailSentDialog(context);
          }
          if(state.exception is InvalidEmailAuthException){
            await showErrorDialog(
              context,
              'Invalid email');
          }else if(state.exception is UserNotFoundAuthException){
            await showErrorDialog(
              context,
              'User not found');
          }
          
        }
    },
    child:  Scaffold(
      appBar: AppBar(title: const Text('Forgot password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Text('Enter your email and tap the button below and we will send you a password reset link'),
          TextField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            autofocus: true,
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Your email adress',
            ),
          ),
          CupertinoButton(child: Text('Reset password'), 
          onPressed: (){
            final email = _controller.text;
            context
            .read<AuthBloc>()
            .add(AuthEventForgotPassword(email: email));
          }),
          CupertinoButton(child: Text('Go to login page'), 
          onPressed: (){
            context.read<AuthBloc>().add(AuthEventLogOut());
          })
        ],),
      ),
    ),
    );
  }
}