import 'package:demo_firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  String? a;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final emailUser = user?.email != null ? user!.email : 'rong';

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Login())));
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Center(child: Text('Welcome : $emailUser')),
    );
  }
}
