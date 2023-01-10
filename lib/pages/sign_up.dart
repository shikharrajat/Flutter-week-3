import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_screen.dart';

import '../main.dart';
import '../reusable_widget.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  String? _error;
  final TextEditingController _textEditingControlleremail = TextEditingController();
  final TextEditingController _textEditingControllerpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple,
                  Colors.pink
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Image.asset("assets/images/logo_movieapp.png",width: 200,),
            ),
            buildTextField("Enter email", _textEditingControlleremail, Icon(Icons.person,color: Colors.white,),false),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: buildTextField("Enter Password", _textEditingControllerpass, Icon(
                Icons.lock,
                color: Colors.white,
              ), true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 45,
                  child: ClipRRect(
                    child: Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: createacc,
                            style: ButtonStyle(
                              //side: MaterialStateProperty.resolveWith((states) => BorderSide(color: Colors.white,width: 2)),
                                elevation: MaterialStateProperty.resolveWith((states) => 0),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white60)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Checkbox.width*2),
                                  child: Text("Sign-up",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          );
                        }
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future createacc() async {
    @required String _email=_textEditingControlleremail.text;
    @required String _password=_textEditingControllerpass.text;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=> Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:_email ,
        password: _password,
      ).then((value) =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoviesHome())));

    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
      navigatorkey.currentState!.popUntil((route) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => signUp()));
        return true;
      },);
    }

    if (_error != null) {
      var snackBar =SnackBar(content: Text(_error??""),duration: Duration(seconds: 2),);
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);}


  }
}