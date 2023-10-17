// ignore_for_file: use_build_context_synchronously

import 'package:bagwan/homepg.dart';
import 'package:bagwan/register.dart';
import 'package:bagwan/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.25,
        leading:null,
        actions: [
          Container(
            height: h * 0.3,
            width: w,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 28, 104),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(h * 0.1),
                    bottomRight: Radius.circular(h * 0.1))),
            child:
                const Center(child: Image(image: AssetImage('assets/bcl.png'))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: w * 0.1, top: h * 0.05, right: w * 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME \n    BACK',
                    style: TextStyle(
                        fontSize: h * 0.05,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: TextFormField(
                        controller: emailctrl,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            focusColor: Colors.yellow)),
                  ),
                  TextFormField(
                      controller: passwordctrl,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.key_rounded),
                          focusColor: Colors.yellow)),
                  Padding(
                      padding: EdgeInsets.only(left: w * 0.35, top: h * 0.03),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Reset()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontFamily: "Times New Roman",
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                color: Color.fromARGB(255, 4, 28, 104)),
                          ))),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.1),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                side: const BorderSide(
                                    color: Colors.yellow, width: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.05, vertical: h * 0.01)),
                            child: const Text(
                              'SIGNUP',
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  color: Color.fromARGB(255, 4, 28, 104),
                                  fontSize: 20),
                            )),
                        SizedBox(
                          width: w * 0.15,
                        ),
                        ElevatedButton(
                            onPressed: isLoading ? null : _loginUser,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.1, vertical: h * 0.01),
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 28, 104),
                                side: const BorderSide(
                                    color: Colors.yellow, width: 2)),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text('LOGIN',
                                    style: TextStyle(
                                      fontFamily: "Times New Roman",
                                        color: Colors.white, fontSize: 20)))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
  try {
    setState(() {
      isLoading = true;
    });

    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: emailctrl.text,
      password: passwordctrl.text,
    );

 
    if (userCredential.user != null) {
      Fluttertoast.showToast(
        msg: 'Login successful',
        backgroundColor: Colors.green,
      );

 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homepg()),
      );
    } else {
      // User is not registered
      Fluttertoast.showToast(
        msg: 'User not registered',
        backgroundColor: Colors.red,
      );
    }
  } catch (error) {
    Fluttertoast.showToast(
      msg: 'Error: $error',
      backgroundColor: Colors.red,
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

}