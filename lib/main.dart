import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FloatingActionButton.extended(
            backgroundColor: Colors.cyan,
            onPressed: () async {
              // initial testing for connection with Firestore
              FirebaseFirestore _db = FirebaseFirestore.instance;

              await _db.collection("test_collection").doc("test_doc_id").set({
                "test_string": "hello world",
                "test_int": 123,
                "test_boolean": true,
                "test_timestamp": Timestamp.now(),
              });

              debugPrint("Data sent to Firestore.");
            },
            label: Text("Send data to FS"),
          ),
        ),
      ),
    );
  }
}
