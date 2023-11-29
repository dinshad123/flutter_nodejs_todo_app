import 'dart:convert';
import 'package:fluter_nodejs_todo_app/screens/login_signup_background.dart';
import 'package:fluter_nodejs_todo_app/screens/signup_screen.dart';
import 'package:fluter_nodejs_todo_app/screens/todo_list_screen.dart';
import 'package:fluter_nodejs_todo_app/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void loginScreen() async {
    var regBody = {
      "email": _emailController.text,
      "password": _passwordController.text
    };

    var response = await http.post(Uri.parse(registration),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const ToDoListScreen();
      }));
    }
  }

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
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log in',
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
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
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
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
                    minimumSize: MaterialStateProperty.all(const Size(280, 60)),
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 209, 134, 226))),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loginScreen();
                  }
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const SignupScreen();
                          }),
                        );
                      },
                      child: const Text('Sign up')),
                ]),
          ],
        ),
      )),
    );
  }
}
