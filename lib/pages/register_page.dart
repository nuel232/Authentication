import 'package:authentication/components/my_button.dart';
import 'package:authentication/components/my_textfield.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() async {
    //show a loading screen
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    //try creating the user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage('Passwords don\'t match');
      }
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //WRONG EMAIL
      if (e.code == 'invalid-email') {
        //SHOW ERROR TO USER
        await Future.delayed(Duration(milliseconds: 100));
        showErrorMessage('Incorrect email');
      }
      //WRONG PASSWORD
      else if (e.code == 'invalid-credential') {
        //show error to user
        await Future.delayed(Duration(milliseconds: 100));
        showErrorMessage('Incorrect password');
      } else {
        // Generic error message for other cases
        showErrorMessage(
          'Login failed. Please check your credentials and try again.',
        );
      }
    }
  }

  //generic error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: true,
      //safeArea make the UI avoid the notch area of the device
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //this make it easier when working with different scree sizes
            children: [
              const SizedBox(height: 25),
              //logo
              Icon(Icons.lock, size: 80),

              const SizedBox(height: 25),

              //welcome back
              Text(
                'Let\'s create an account for you',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),

              SizedBox(height: 25),

              //username textfield
              MyTextfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(height: 15),

              //password textfield
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: 15),

              //confirm password textfield
              MyTextfield(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              SizedBox(height: 25),

              // sign in button
              MyButton(onTap: signUserUp, text: 'Sign Up'),

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
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
