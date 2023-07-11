import 'package:fire_chat/app_router.dart';
import 'package:fire_chat/firebase_options.dart';
import 'package:fire_chat/sqlite/crud.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return MaterialApp(
      title: 'Fire Chat',
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  @override
  void initState() {
    Crud.init();
    super.initState();
  }
}

// void main() {
//   runApp(App());
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AppRouter appRouter = AppRouter();
//     return FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           print(snapshot.error.toString());
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           print(ConnectionState.done.toString());
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return SignInForm();
//       },
//     );
//   }
// }


