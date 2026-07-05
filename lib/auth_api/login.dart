import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passworddController = TextEditingController();
  void login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {'email': email, 'password': password},
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('LOGIN Successfull!')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('POST REQUEST USING API'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(controller: emailController),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(controller: passworddController),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                login(
                  emailController.text.toString(),
                  passworddController.text.toString(),
                );
              },
              child: Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
