// ignore_for_file: use_build_context_synchronously

import 'package:bagwan/login.dart';
import 'package:bagwan/privacy_policy.dart';
import 'package:bagwan/terms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();
  TextEditingController cpasswordctrl = TextEditingController();
  bool acceptedTerms = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.25,
        actions: [
          Container(
            height: h * 0.3,
            width: w,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 28, 104),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(h * 0.1),
                    bottomRight: Radius.circular(h * 0.1))),
            child: const Center(
                child: Image(image: AssetImage('assets/bcl2rmv.png'))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: w * 0.1, top: h * 0.05, right: w * 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create your account',
                    style: TextStyle(
                        fontSize: h * 0.03,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: TextFormField(
                        controller: namectrl,
                        decoration: const InputDecoration(
                            hintText: 'Full Name',
                            suffixIcon: Icon(Icons.text_decrease_rounded,
                                color: Colors.yellow),
                            focusColor: Colors.yellow)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: TextFormField(
                        controller: emailctrl,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            suffixIcon: Icon(Icons.email_outlined,
                                color: Colors.yellow),
                            focusColor: Colors.yellow)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: TextFormField(
                        controller: phonectrl,
                        decoration: const InputDecoration(
                            hintText: 'Phone',
                            suffixIcon: Icon(Icons.phone_android_rounded,
                                color: Colors.yellow),
                            focusColor: Colors.yellow)),
                  ),
                  TextFormField(
                      controller: passwordctrl,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          suffixIcon: Icon(
                            Icons.key_rounded,
                            color: Colors.yellow,
                          ),
                          focusColor: Colors.yellow)),
                  TextFormField(
                      controller: cpasswordctrl,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: Icon(
                            Icons.key_rounded,
                            color: Colors.yellow,
                          ),
                          focusColor: Colors.yellow)),
                  Wrap(
                    runSpacing: 0.0,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                          value: acceptedTerms,
                          onChanged: (newValue) {
                            setState(() {
                              acceptedTerms = newValue!;
                            });
                          }),
                      //const Text('I accept the '),
                      InkWell(
                        onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Privacy()));
                          
                        },
                        child: const Text(
                          'Privacy policy',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const Text(' and '),
                      InkWell(
                        onTap: () {
                          
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Terms()));
                          
                        },
                        child: const Text(
                          'Terms and conditions',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.05),
                    child: Wrap(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                side: const BorderSide(
                                    color: Colors.yellow, width: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.05, vertical: h * 0.01)),
                            child: const Text(
                              'SIGNIN',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 4, 28, 104),fontFamily: "Times New Roman",
                                  fontSize: 20),
                            )),
                        SizedBox(
                          width: w * 0.1,
                        ),
                        ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (acceptedTerms) {
                                      _signUpUser(); // Call the signup function
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Accept the terms and conditions',
                                          style: TextStyle(color: Colors.white, fontFamily: "Times New Roman",),
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.1, vertical: h * 0.01),
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 28, 104),
                                side: const BorderSide(
                                    color: Colors.yellow, width: 2)),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text('SIGNUP',
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

  Future<void> _signUpUser() async {
    if (passwordctrl.text != cpasswordctrl.text) {
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }

    if (!isValidEmail(emailctrl.text)) {
      Fluttertoast.showToast(msg: 'Invalid email format');
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailctrl.text,
        password: passwordctrl.text,
      );

      await usersCollection.doc(userCredential.user?.uid).set({
        'name': namectrl.text,
        'email': emailctrl.text,
        'phone': phonectrl.text,
      });
      Fluttertoast.showToast(
          msg: 'Account created successfully', backgroundColor: Colors.green);
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error', backgroundColor: Colors.red);
    } finally {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }
}
