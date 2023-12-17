import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test/screens/chat_Page.dart';
import 'package:test/screens/register_Screen.dart';
import 'package:test/widgets/custom_button.dart';
import 'package:test/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLooding = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Image.asset(
                'assets/images/scholar.png',
              ),
              const Text(
                'Scholar Chat',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'pacifico',
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              const Row(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChange: (data) {
                  email = data;
                },
                hintText: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                password: true,
                onChange: (data) {
                  password = data;
                },
                hintText: 'Password',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () async {
                  // i >> not null
                  if (formKey.currentState!.validate()) {
                    isLooding = true;
                    setState(() {});
                    try {
                      await loginUser();
                      Navigator.pushNamed(
                        context,
                        ChatPage.id,
                        arguments: email,
                      );
                      // arguments to send data to new screen so that I will use email in firestore
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user.');
                      }
                    }
                    isLooding = false;
                    setState(() {});
                  } else {}
                },
                text: 'LOGIN',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                    child: const Text(
                      '  Register',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
