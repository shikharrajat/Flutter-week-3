import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/sign_up.dart';
import 'package:movie_app/reusable_widget.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String? _error;
  final TextEditingController _textEditingControlleremail =
  TextEditingController();
  final TextEditingController _textEditingControllerpass =
  TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple, Colors.pink])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset("assets/images/film_project-removebg.png",width: 300,),
            ),
            SizedBox(
              height: 30,
            ),
            buildTextField("Enter email", _textEditingControlleremail, Icon(Icons.person,color: Colors.white,),false),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: buildTextField("Enter Password", _textEditingControllerpass, Icon(
                Icons.lock,
                color: Colors.white,
              ), true),
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 45,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(29),
                    child: ElevatedButton(
                      onPressed: signIn,
                      style: ButtonStyle(
                          side: MaterialStateProperty.resolveWith((states) =>
                              BorderSide(color: Colors.white, width: 2)),
                          elevation:
                          MaterialStateProperty.resolveWith((states) => 0),
                          backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.lock_open_outlined),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                return RichText(
                  text: TextSpan(
                      text: "Don't have a account?  ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => signUp()));
                            },
                          style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                          ),
                          text: "Sign-up",
                        ),
                      ]),
                );
              }),
            ),
            // showAlert(),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    @required String _email=_textEditingControlleremail.text;
    @required String _password=_textEditingControllerpass.text;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=> Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:_email ,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
    }
    navigatorkey.currentState!.popUntil((route) => route.isFirst,);
    if (_error != null) {
      var snackBar =SnackBar(content: Text(_error??""),duration: Duration(seconds: 2),);
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);}

  }
}
