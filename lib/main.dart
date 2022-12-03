import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insekul_app/Custom/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Find Your Job is being initialized',
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Signatra'
                  ),
                ),
              ),
            ),
          );
        }
        else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('An error has been occured',
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Find Your Job',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UserState(),
        );
      },
    );
  }
}
