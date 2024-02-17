import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  IntroPage1({Key? key, required this.message}) : super(key: key);
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
            //logo
            Hero(
              tag: 'iconlogo',
              child: Image.asset(
                'assets/IRYS_ICON.png',
                height: 250,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 16, ),
                  ),
                ),
              ],
            ),
             const SizedBox(
              height: 100,
            ),
                  ],
                ),
          )),
    );
  }
}
