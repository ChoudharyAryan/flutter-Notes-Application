import 'package:flutter/material.dart';
import 'package:flutter_sem_2/constants/routes.dart';
import 'package:flutter_sem_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_sem_2/services/auth/firebase_auth_provider.dart';
import 'package:flutter_sem_2/views/login_view.dart';
import 'package:flutter_sem_2/views/notes/create_update_note_view.dart';
import 'package:flutter_sem_2/views/notes/notes_view.dart';
import 'package:flutter_sem_2/views/register_view.dart';
import 'package:flutter_sem_2/views/verify_email_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(create: ((context) => AuthBloc(FireBaseAuthProvider(),)),
      child:const HomePage(),),      
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc,AuthState>(builder: (context , state) {
      if(state is AuthStateLoggedIn){
        return const NotesView();
      }else if(state is AuthStateNeedsVerification){
        return const VerifyEmailView();
      }else if(state is AuthStateLoggedOut){
        return const LoginView();
      }else{
        return const Scaffold(
          body: Center(
            child:
            CircularProgressIndicator()),
        );
      }
    });






    // return FutureBuilder(
    //   future: AuthService.firebase().initialize(),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         final user = AuthService.firebase().currentuser;
    //         if (user != null) {
    //           if (user.isEmailVerified) {
    //             return const NotesView();
    //           } else {
    //             return const VerifyEmailView();
    //           }
    //         } else {
    //           return const LoginView();
    //         }
    //       default:
    //         return const CircularProgressIndicator();
    //     }
    //   },
    // );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
      // routes: {
      //   loginRoute: (context) => const LoginView(),
      //   registerRoute: (context) => const RegisterView(),
      //   notesRoute: (context) => const NotesView(),
      //   verifyEmailRoute: (context) => const VerifyEmailView(),
      //   createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      // },
//     ),
//   );
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Testing Blok'),
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInValidNumber) ? state.inValidValue : '';
//             return Column(
//               children: [
//                 Text('Current Value => ${state.value}'),
//                 Visibility(
//                   visible: state is CounterStateInValidNumber,
//                   child: Text('Invalid input $invalidValue'),
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter a Number',
//                   ),
//                   textAlign: TextAlign.center,
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                   CupertinoButton(
//                     color: Colors.amber,
//                     pressedOpacity: 0,
//                     child: const Text('ADD'), onPressed: (){
//                     context.read<CounterBloc>().add(IncrementEvent(_controller.text));
//                   }),
//                   CupertinoButton(
//                     color: Colors.red,
//                     pressedOpacity: 1,
//                     child: const Text('MINUS'), onPressed: (){
//                     context.read<CounterBloc>().add(DecrementEvent(_controller.text));
//                   }),
//                 ],)
//               ],
//             );
//           },
//           listener: (context, state) {
//             _controller.clear();
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;
//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInValidNumber extends CounterState {
//   final String inValidValue;

//   const CounterStateInValidNumber({
//     required this.inValidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(CounterStateInValidNumber(
//             inValidValue: event.value, previousValue: state.value));
//       } else {
//         emit(CounterStateValid(state.value + integer));
//       }
//     });
//     on<DecrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(CounterStateInValidNumber(
//             inValidValue: event.value, previousValue: state.value));
//       } else {
//         emit(CounterStateValid(state.value - integer));
//       }
//     });
//   }
// }
