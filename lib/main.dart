import 'package:fire_chat/app_router.dart';
import 'package:fire_chat/firebase_options.dart';
import 'package:fire_chat/sqlite/crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void dispose() {
    FirebaseAuth.instance.signOut();
    print('Log Out');
    super.dispose();
  }

  @override
  void initState() {
    Crud.init();
    super.initState();
  }
}
