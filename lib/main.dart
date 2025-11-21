import 'package:flutter/material.dart';
import 'package:flutter_form_generator/flutter_form_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FormGenerator formGenerator = FormGenerator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: formGenerator.generateForm( {
          "type": "form",
          "title": "User Registration",
          "fields": [
            {
              "type": "text_input",
              "name": "full_name",
              "label": "Full Name",
              "placeholder": "Enter your full name",
              "required": true,
              "maxLength": 50
            },
            {
              "type": "email_input",
              "name": "email",
              "label": "Email Address",
              "placeholder": "example@mail.com",
              "required": true,
              "validation": {
                "regex": "^[\\w.-]+@[\\w.-]+\\.\\w{2,}",
                "error_message": "Enter a valid email"
              }
            },
            {
              "type": "number_input",
              "name": "age",
              "label": "Age",
              "placeholder": "18",
              "required": true,
              "min": 18,
              "max": 100
            },
            {
              "type": "dropdown",
              "name": "gender",
              "label": "Gender",
              "options": [
                { "label": "Male", "value": "male" },
                { "label": "Female", "value": "female" },
                { "label": "Other", "value": "other" }
              ],
              "required": true
            },
            {
              "type": "checkbox",
              "name": "terms",
              "label": "I agree to the Terms & Conditions",
              "required": true
            }
          ],
          "submit": {
            "type": "button",
            "label": "Register",
            "action": {
              "type": "api_call",
              "method": "POST",
              "url": "https://api.example.com/register",
              "success_message": "Registration successful",
              "error_message": "Registration failed"
            }
          }
        }
        ),
      ),
    );
  }
}
