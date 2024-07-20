import 'package:cipra_ai_project/login.dart';
import 'package:cipra_ai_project/provider/appprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BackEndProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );


    
  }
}