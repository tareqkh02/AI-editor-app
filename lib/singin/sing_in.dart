import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AI_editor_app/Api/loging_api.dart'; // Ensure this file contains login and register API functions
import 'package:AI_editor_app/singin/sing_up.dart';
// Add a new file for registration API
import 'package:AI_editor_app/singin/widget/sing_in_widget.dart';
import 'package:AI_editor_app/textEdetor/textEdetor.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String _errorMessage = '';

  void handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    print("Logging in with: $email"); 

    final result =
        await signInUser(email, password, true,context); 

    if (result != null && result['success'] == true) {
      print('✅ Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TextEdetor()),
      );
    } else {
      setState(() {
        _errorMessage =
            result?['message'] ?? 'Invalid credentials, please try again.';
      });
    }
  }

  void handleRegister() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Singup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildThreadParty(context),
                Center(
                    child: reusabelText("Or use your email account to login ")),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusabelText("Email"),
                      SizedBox(height: 5.h),
                      buildTextfild("Enter your Email address", "email", "user",
                          _emailController),
                      reusabelText("Password"),
                      SizedBox(height: 5.h),
                      buildTextfild("Enter your Email password", "password",
                          "lock", _passwordController),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(_errorMessage,
                              style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                ),
                forgetpassword(),
                buildLogiandRegbutton("Log In", "login", handleLogin),
                buildLogiandRegbutton("Register", "Register", handleRegister),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
