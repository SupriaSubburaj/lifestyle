import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


// ignore: non_constant_identifier_names
String SERVER_URL = dotenv.get("SERVER_URL");

class BackEndProvider extends DisposableProvider {
  String getServerUrl() {
    return SERVER_URL;
  }

   String loginErrorMsg = "";
  
  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
  
  //===Login api call====//
  
  
}

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}
