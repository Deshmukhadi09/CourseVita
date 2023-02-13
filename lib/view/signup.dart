import 'package:flutter/material.dart';
import 'package:video_stream/view/signin.dart';
import 'package:video_stream/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String email, password, name;
  final bool _isLoading = false;
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
      body: _isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Name" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter name",
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Email Id" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Password" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _firebaseAuth
                            .createUserWithEmailAndPassword(
                                email: email, //_emailController.text,
                                password: password)
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection('UserData')
                              .doc(email)
                              .set({
                            "name": name,
                            "email": value.user!.email,
                            "role": "user",
                            "uid": value.user!.uid,
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("You are succesfully registered"),
                                backgroundColor: Colors.greenAccent));
                      },
                      child: blueButton(context, "Sign Up"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have account?",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: const Text(
                              " Sign In",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
