import 'package:flutter/material.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify e-mail'),
      ),
      body: Column(children: [
        const Text(
            "we've just sent you an email verification please click on the link to verify your email"),
        const Text(
            "if you haven't recived the verification link yet press the button below to send it again"),
        TextButton(
          onPressed: () async {
            AuthService.firebase().sendEmailVerification();
          },
          child: const Text('send email verification'),
        ),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logout();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
          },
          child: const Text('Restart'),
        ),
      ]),
    );
  }
}
