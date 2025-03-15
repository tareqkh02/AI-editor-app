import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:AI_editor_app/class/AuthProvider.dart';
import 'package:provider/provider.dart';

Future<Map<String, dynamic>> signUpUser(
    String email, String password, String name, bool recall) async {
  final url = Uri.parse(
      'https://neo-codex-ai-backend.onrender.com/api/public/auth/signup');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "name": name,
      "recall": recall,
    }),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    String? token = data['data']?['accessToken'];

    if (token != null) {
      print('Access token: $token');
      return {
        'success': true,
        'message': 'Sign-up successful',
        'token': token, // Return token in the response map
      };
    } else {
      print('Error: Access token is null');
      return {'success': false, 'message': 'Failed to sign up'};
    }
  } else {
    print("Failed to sign up: ${response.statusCode} - ${response.body}");
    return {'success': false, 'message': 'Failed to sign up'};
  }
}

Future<Map<String, dynamic>> signInUser(
    String email, String password, bool recall, BuildContext context) async {
  final url = Uri.parse(
      'https://neo-codex-ai-backend.onrender.com/api/public/auth/signin');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "recall": recall,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("User signed in successfully: ${response.body}");
    String? token = data['data']?['accessToken'];

    if (token != null) {
      print('Access token: $token');
      Provider.of<AuthProvider>(context, listen: false).setAuthToken(token);

      // Proceed with using the token
    } else {
      print('Error: Access token is null');
    }

    return {'success': true, 'message': 'Login successful'};
  } else {
    print("Failed to sign In: ${response.statusCode} - ${response.body}");

    return {'success': false, 'message': 'Failed to sign In'};
  }
}

Future<void> fetchCodeReview() async {
  final url = Uri.parse(
      'https://neo-codex-ai-backend.onrender.com/api/private/code/review');

  final response = await http.get(
    url,
    headers: {
      "Authorization": "Bearer",
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Response: ${data['message']}");
    print("Code Review: ${data['data']['explanation']}");
  } else {
    print("Error: ${response.statusCode} - ${response.body}");
  }
}

Future<String?> sendToAPI(String message, BuildContext context) async {
  final url =
      Uri.parse('https://neo-codex-ai-backend.onrender.com/api/private/mentor');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  if (authToken == null) {
    print("No auth token found.");
  } else {
    print("The auth token: $authToken");

    if (message == null || message.trim().isEmpty) {
      print("Prompt (message) cannot be empty");
    }

    final body = jsonEncode({
      "prompt": message,
      "modelAi": "gemini",
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': '2e46b067981b5d8b1b4a $authToken',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data']['answers'][0]['answer'];
      } else {
        return "Failed to get a response from the API. Status code: ${response.statusCode}";
      }
    } catch (e) {
      print('Error: $e');
      return "Error occurred while sending the message.";
    }
  }
  return null;
}

Future<Map<String, String>?> profile(BuildContext context) async {
  final url = Uri.parse(
      "https://neo-codex-ai-backend.onrender.com/api/private/user/me");
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  print("Auth Token: $authToken");
  final response = await http.get(
    url,
    headers: {
      'Authorization': '2e46b067981b5d8b1b4a $authToken',
      'Content-Type': 'application/json',
    },
  );
  print("Response Code: ${response.statusCode}");
  print("Response Body: ${response.body}");
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    print("Parsed Data: $data");
    return {
      'name': data['data']['name'],
      'email': data['data']['email'],
    };
  } else {
    print(
        "Failed to get a response from the API. Status code: ${response.statusCode}");
    return null;
  }
}

Future<List<String>?> chats(BuildContext context) async {
  final url = Uri.parse(
      "https://neo-codex-ai-backend.onrender.com/api/private/user/chats");
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  print("Auth Token: $authToken");
  final response = await http.get(
    url,
    headers: {
      'Authorization': '2e46b067981b5d8b1b4a $authToken',
      'Content-Type': 'application/json',
    },
  );
  print("Response Code: ${response.statusCode}");
  print("Response Body: ${response.body}");
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    print("Parsed Data: $data");

    List<String> names =
        (data['data'] as List).map((chat) => chat['name'].toString()).toList();

    return names;
  } else {
    print(
        "Failed to get a response from the API. Status code: ${response.statusCode}");
    return null;
  }
}

Future<Map<String, String>?> sendToAPIcode(
    String message, String code, BuildContext context) async {
  final url = Uri.parse(
      'https://neo-codex-ai-backend.onrender.com/api/private/code/review');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  if (authToken == null) {
    print("No auth token found.");
  } else {
    print("The auth token: $authToken");

    if (message == null ||
        message.trim().isEmpty ||
        code == null ||
        code.trim().isEmpty) {
      print("Prompt (message) cannot be empty");
    }

    final body = jsonEncode({
      "prompt": message,
      "code": code,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': '2e46b067981b5d8b1b4a $authToken',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'response': data['data']['response'],
          'explanation': data['data']['explanation']
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
