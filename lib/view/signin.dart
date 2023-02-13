import 'package:flutter/material.dart';
import 'package:video_stream/view/signup.dart';
import 'package:video_stream/view/splashscreen.dart';
import 'package:video_stream/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading ? Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              const Spacer(),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Enter Email Id" : null ;},
                decoration: const InputDecoration(
                  hintText: "Enter email",
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Enter Password" : null ;},
                decoration: const InputDecoration(
                  hintText: "Enter password",
                ),
                onChanged: (val){
                  password = val;
                },
              ),
              const SizedBox(height: 24,),
              GestureDetector(
                onTap: () async{
                  //write your singin logic here
                  await _firebaseAuth
                                .signInWithEmailAndPassword(
                                    email: email,
                                    password: password)
                                .then((value) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SplashScreen()));
                                });
                },
                child:blueButton(context, "Sign In"),
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?",style: TextStyle(fontSize: 15.5),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignUp()
                      ));
                    },
                      child: const Text(" Sign Up",style: TextStyle(color: Colors.blue,fontSize: 15.5,decoration: TextDecoration.underline),))
                ],
              ),
              const SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}
