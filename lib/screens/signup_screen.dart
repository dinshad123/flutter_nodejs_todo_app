import 'package:fluter_nodejs_todo_app/screens/login_screen.dart';
import 'package:fluter_nodejs_todo_app/screens/login_signup_background.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Body(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 35,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        color: Color.fromARGB(255, 225, 121, 237),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: Colors.blueAccent)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email address';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                  },
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 225, 121, 237),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.blueAccent)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all(const Size(280, 60)),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 209, 134, 226))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }),
                        );
                      },
                      child: Text('Login in'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
