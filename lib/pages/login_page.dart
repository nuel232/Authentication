import 'package:authentication/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //safeArea make the UI avoid the notch area of the device
      body: SafeArea(
        child: Center(
          child: Column(
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
                controller: usernameController,
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
              Row(
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

              // sign in button

              //or continue with

              // goggle + apple sign in buttons

              //not a member? register
            ],
          ),
        ),
      ),
    );
  }
}
