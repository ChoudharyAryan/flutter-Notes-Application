import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/auth_service.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          color: Colors.blue,
        ),
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18))),
        centerTitle: true,
        title: const Text('Verify e-mail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
              child: const Text(
                  "we've just sent you an email verification please click on the link to verify your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,wordSpacing: 5),),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                    ),
              child: const Text(
                  "if you haven't recived the verification link yet press the button below to send it again",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,wordSpacing: 5)
                  ,),
            ),        
            const SizedBox(height: 20,),
            CupertinoButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text('send email verification'),
            ),
            CupertinoButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text('Restart'),
            ),
            Container(
              child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_ebqz3ltq.json',
              reverse: true),
            )
          ],
          ),
        ),
      ),
    );
  }
}
