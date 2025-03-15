import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AI_editor_app/Api/loging_api.dart'; // Ensure this file contains login and register API functions
import 'package:AI_editor_app/singin/sing_in.dart';
// Add a new file for registration API
import 'package:AI_editor_app/singin/widget/sing_in_widget.dart';
import 'package:AI_editor_app/textEdetor/textEdetor.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String _errorMessage = '';

  void havAccount() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SingIn()),
    );
  }

  void handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _usernameController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    print("Logging in with: $email"); // Debugging

    final result =
        await signUpUser(email, password, name, true); // Call login API

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
    /*  final name = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all fields.';
      });
      return;
    }

    print("Registering user: $name, $email");

    final result = await register(name, email, password); // Call register API

    if (result != null && result['success'] == true) {
      print('✅ Registration successful');
      setState(() {
        _errorMessage = 'Registration successful. Please log in.';
      });
    } else {
      setState(() {
        _errorMessage =
            result?['message'] ?? 'Registration failed, please try again.';
      });
    } */
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
                Container(
                  margin: EdgeInsets.only(top: 60.h),
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusabelText("Name"),
                      SizedBox(height: 5.h),
                      buildTextfild("Enter your Name", "name", "user",
                          _usernameController),
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
                buildLogiandRegbutton("Log In", "login", handleLogin),
                haveAccount(havAccount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
