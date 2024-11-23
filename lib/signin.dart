import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(255, 94, 72, 40),
              //     Color.fromARGB(255, 177, 142, 90),
              //     Color.fromARGB(255, 177, 142, 90),
              //   ],
              // ),
              color:                      Color.fromARGB(255, 71, 102, 52),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Welcome\nSign Up!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField("Email"),
                    const SizedBox(height: 20),
                    _buildTextField("Password", obscureText: true),
                    const SizedBox(height: 20),
                    _buildTextField("Confirm Password", obscureText: true),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:                      Color.fromARGB(255, 71, 102, 52),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // const Text(
                    //   "Already have an account? Log in",
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    const SizedBox(height: 30),
                    const Text(
                      "CONTINUE WITH SOCIAL MEDIA!!",
                      style: TextStyle(color: Colors.black),
                    ),
                    // Social media buttons can be added here if needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool obscureText = false}) {
    return Container(
      constraints: BoxConstraints(maxWidth: double.infinity), // Ensure the width is bounded
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color:                      Color.fromARGB(255, 71, 102, 52),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
