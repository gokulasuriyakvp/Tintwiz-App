import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController yourNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isChecked = false;
  bool isLoading = false;


  Padding _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create Your Account",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 5,
                child: Container(
                  height: 500,
                  width: 600,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTextField(
                          label: "Your Name",
                          controller: yourNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Email Address",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Password",
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          label: "Confirm Password",
                          controller: confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: const Color(0xff6AB187),
                              onChanged: (newBool) {
                                setState(() {
                                  isChecked = newBool!;
                                });
                              },
                            ),
                            const Text("I agree to the Terms and Conditions"),
                          ],
                        ),
                        if (!isChecked)
                          const Text(
                            "Please agree to the terms to proceed",
                            style: TextStyle(color: Colors.red),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6AB187),
                            minimumSize: const Size(40, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate() && isChecked) {
                              registerUser(context); // Correctly call the function and pass context
                            } else if (!isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('You must agree to the terms')),
                              );
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(context) async {
    setState(() {
      isLoading = true;
    });
    if (passwordController.text == confirmPasswordController.text) {
      try {
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        User? user = userCredential.user;
        if (user != null) {
          await user.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                Text('Verification email sent! Please check your inbox')),
          );
          _checkEmailVerified(user, context);
          await _firestore.collection('Register').doc(user.uid).set({
            'name': yourNameController.text,
            'email': emailController.text,
            'uid': user.uid,
            'fcmToken': '',
          });
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _checkEmailVerified(User user, context) async {
    Timer timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await user.reload();
      user = _auth.currentUser!;
      if (user.emailVerified) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Email verified! You can Login after getting Approved by Admin.')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
    Future.delayed(const Duration(minutes: 1), () async {
      if (!user.emailVerified) {
        await user.delete();
        timer.cancel();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verification failed.')),
        );
      }
    });
  }


}
