import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 22, 0.843),
      bottomSheet: Row(
        children: [
          TextButton(
            onPressed: (){},
             child:Text("skip")),

             TextButton(
            onPressed: (){},
             child:Text("next")),
        ],
      ),
    );
  }
}