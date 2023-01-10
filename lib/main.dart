import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/pages/sign_in.dart';
import 'package:movie_app/pages/home_screen.dart';

import 'firebase_options.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}
final navigatorkey= GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text("Something went wrong"));
            }
            else if(snapshot.hasData){
              return MoviesHome();
            }
            else{
              return login();
            }

          }
      ),
    );
  }
}
