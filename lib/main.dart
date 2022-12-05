import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hang/newGame/screens/sign_up.dart';
import 'package:provider/provider.dart';
import 'home/screens/home.dart';
import 'newGame/data/providers/auth_state_hang.dart';
import 'newGame/data/providers/new_game_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewGameProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthState(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthState>().userChanges,
            initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const LoginHandler(),
      ),
    );
  }
}

class LoginHandler extends StatelessWidget {
  const LoginHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    return _firebaseUser == null ? const SignUpPage() : const Home();
  }
}
