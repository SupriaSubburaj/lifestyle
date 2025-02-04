import 'package:flutter/material.dart';

class Lifestyle extends StatelessWidget {
  const Lifestyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          leading: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),      
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, //===Image is scrollable vertically ====//
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            child: Image.asset(
              'assets/images/recommendations.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              
            ),
          ),
        ),
      ),
    );
  }
}
