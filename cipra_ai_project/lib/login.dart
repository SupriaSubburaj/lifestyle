import 'package:cipra_ai_project/lifestyle.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

String loginErrorMsg = "";

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
      backgroundColor: Colors.white,
      appBar: AppBar(
          ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          child: Image.asset(
                            'assets/images/cipra_logo.jpg', //===add Cipra logo from assets folder =====//
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        //===Get email input====//
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //===Get password input====//
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Password',
                          hintText: 'Enter secure password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  //=====display error if there is any error message =====//
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Center(
                      child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { //====validate the form and submit ====//
                        login();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                  ))
                ],
              ),
            )),
      ),
    );
  }

//===== Login with credentials =====// 
  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    String username = usernameController.text;
    String password = passwordController.text;

    final response = await _getResponse(username, password);
    print('Login response:$response');
    if (response == '') {
      setState(() {
        isLoading = false;
        errorMessage = loginErrorMsg;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = '';
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Lifestyle())); //--- Navigate to Screen2 after successfull login ----//
      });
    }
  }
}

//==== Get login response from cipra api =====//
Future<String> _getResponse(String username, String password) async {
  try {
    final url = Uri.parse("https://api.cipra.ai:5000/takehome/signin")
        .replace(queryParameters: {'email': username, 'password': password});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('res:${response.body}');
      return response.body;
    } else {
      loginErrorMsg = 'Invalid user credentials';
      return "";
    }
  } catch (e) {
    print("Error in login page: $e");
    loginErrorMsg = 'Invalid user credentials';
    return "";
  }
}
