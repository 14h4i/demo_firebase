import 'dart:developer';

import 'package:demo_firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCtl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordCtl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final data = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailCtl.text, password: passwordCtl.text);

                  log(data.toString());

                  log(data.user.toString());

                  if (data.user != null) {
                    // push
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePage())));
                  }
                } on FirebaseAuthException catch (e) {
                  log(e.toString());

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Loi'),
                          content: Text(e.toString()),
                        );
                      });
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final data = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailCtl.text, password: passwordCtl.text);

                  log(data.toString());

                  log(data.user.toString());

                  if (data.user != null) {
                    // push
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text('Thanh Cong'),
                            content: Text('Dang ky thanh cong'),
                          );
                        });
                  }
                } on FirebaseAuthException catch (e) {
                  log(e.toString());

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Loi'),
                          content: Text(e.toString()),
                        );
                      });
                }
              },
              child: const Text('Dang ky'),
            ),
          ],
        ),
      ),
    );
  }
}
