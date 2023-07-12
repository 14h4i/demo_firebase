import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> hocsinh = {};

  List<Map<String, dynamic>> listHocsinh = [];

  final controller = TextEditingController();

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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.close),
              onPressed: () async {
                hocsinh = {};
                listHocsinh = [];

                setState(() {});
              }),
          FloatingActionButton(
              child: const Icon(Icons.get_app),
              onPressed: () async {
                final response =
                    await firestore.collection('data').doc('doc-id-1').get();

                final data = response.data();

                if (data != null) {
                  hocsinh = data;

                  // final name = hocsinh['nameStudent'];

                  // print('Ten hoc sinh la: $name');

                  setState(() {});
                }
              }),
          FloatingActionButton(
              child: const Icon(Icons.download_for_offline_outlined),
              onPressed: () async {
                final response = await firestore.collection('data').get();

                final data = response.docs;

                listHocsinh = [];

                for (var i = 0; i < data.length; i++) {
                  final hocsinh = data[i].data();

                  listHocsinh.add(hocsinh);
                }

                setState(() {});

                print(listHocsinh);
              }),
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Welcome : $emailUser'),
            const SizedBox(
              height: 50,
            ),
            Text("Ten hoc sinh: ${hocsinh['nameStudent']}"),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Danh sach hoc sinh:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listHocsinh.length,
                itemBuilder: ((context, index) {
                  final hocsinh = listHocsinh[index];

                  final name = hocsinh['nameStudent'];

                  return ListTile(
                    title: Text(name),
                  );
                })),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  firestore.collection('data').add({
                    'nameStudent': controller.text,
                    'age': 19,
                  });
                  // firestore.collection('data').doc('doc-id-3').set({
                  //   'nameStudent': controller.text,
                  //   'age': 19,
                  // });
                },
                child: const Text('Add')),
            ElevatedButton(
                onPressed: () {
                  firestore.collection('data').doc('doc-id-2').update({
                    'nameStudent': controller.text,
                  });
                },
                child: const Text('Update')),
          ],
        ),
      )),
    );
  }
}
