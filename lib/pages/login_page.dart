import 'package:authentication/components/my_button.dart';
import 'package:authentication/components/my_textfield.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sing user in method
  //await firebase_auth
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //safeArea make the UI avoid the notch area of the device
      body: SafeArea(
        child: Center(
          child: Column(
            //this make it easier when working with different scree sizes
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              //logo
              Icon(Icons.lock, size: 100),

              const SizedBox(height: 50),

              //welcome back
              Text(
                'welcome back you\'ve been missed',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),

              SizedBox(height: 25),

              //username textfield
              MyTextfield(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),

              SizedBox(height: 15),

              //password textfield
              MyTextfield(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              SizedBox(height: 15),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  //since we want this to be at the right side but the column is center we wrap the text widget into Row
                  //and set the mainAxisAlignment to end
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // sign in button
              MyButton(onTap: signUserIn),

              SizedBox(height: 50),

              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),

                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // goggle + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/images/Google-logo.png'),

                  SizedBox(width: 25),
                  //apple button
                  SquareTile(imagePath: 'lib/images/apple-logo.png'),
                ],
              ),

              SizedBox(height: 30),

              //not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
