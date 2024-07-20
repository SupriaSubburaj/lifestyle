import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//==== Boolean flag to track whether the login is in progress====//
  bool isLoading = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(key:_formKey, child: Column(children: <Widget>[
          TextFormField(controller: usernameController,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value){
            if(value ==null || value.isEmpty){
              return 'Please enter your email';
            }
            return null;
          },),
          TextFormField(controller: usernameController,
          decoration: InputDecoration(labelText: 'Password'),
          validator: (value){
            if(value ==null || value.isEmpty){
              return 'Please enter your password';
            }
            return null;
          },)
        ],)),
      ),
    );
  }
}
