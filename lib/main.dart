import 'package:flutter/material.dart';
import 'package:flutter_form_generator/flutter_form_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FormGenerator formGenerator = FormGenerator(
    headers: {'Authorization': 'Bearer token123', 'Custom-Header': 'value'},
  );

  Widget getFormWrapper(Widget child, {String? title}) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: title == null
              ? Container()
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: child,
        ),
      ),
    );
  }

  void _showForm(
    Map<String, dynamic> formData,
    String title, {
    String? successMessage,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => getFormWrapper(
          formGenerator.generateForm(
            formData,
            onSuccess: (values) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    successMessage ?? "Form submitted successfully",
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
          title: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Form Generator",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showForm(
                  {
                    "type": "form",
                    "title": "User Registration",
                    "fields": [
                      {
                        "type": "text_input",
                        "name": "full_name",
                        "label": "Full Name",
                        "placeholder": "Enter your full name",
                        "required": true,
                        "maxLength": 50,
                      },
                      {
                        "type": "email_input",
                        "name": "email",
                        "label": "Email Address",
                        "placeholder": "example@mail.com",
                        "required": true,
                        "validations": [
                          {
                            "regex": "^[\\w.-]+@[\\w.-]+\\.\\w{2,}",
                            "error_message": "Enter a valid email",
                          },
                        ],
                      },
                      {
                        "type": "number_input",
                        "name": "age",
                        "label": "Age",
                        "placeholder": "18",
                        "required": true,
                        "min": 18,
                        "max": 100,
                      },
                      {
                        "type": "dropdown",
                        "name": "gender",
                        "label": "Gender",
                        "options": [
                          {"label": "Male", "value": "male"},
                          {"label": "Female", "value": "female"},
                          {"label": "Other", "value": "other"},
                        ],
                        "required": true,
                      },
                      {
                        "type": "checkbox",
                        "name": "terms",
                        "label": "I agree to the Terms & Conditions",
                        "required": true,
                      },
                    ],
                    "submit": {
                      "type": "button",
                      "label": "Register",
                      "action": {
                        "type": "api_call",
                        "method": "POST",
                        "url": "https://jsonplaceholder.typicode.com/users",
                        "success_message": "Registration successful",
                        "error_message": "Registration failed",
                      },
                    },
                    "reset": true,
                  },
                  "User Registration",
                  successMessage: "Registration successful",
                ),
                child: const Text("User Registration Form"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showForm(
                  {
                    "type": "form",
                    "title": "Login",
                    "fields": [
                      {
                        "type": "email_input",
                        "name": "email",
                        "label": "Email Address",
                        "placeholder": "example@mail.com",
                        "required": true,
                      },
                      {
                        "type": "password_input",
                        "name": "password",
                        "label": "Password",
                        "placeholder": "Enter a strong password",
                        "required": true,
                        "minLength": 8,
                        "validations": [
                          {
                            "regex": "^.{8,}\$",
                            "error_message":
                                "Password must be at least 8 characters long",
                          },
                          {
                            "regex": "^(?=.*[A-Z]).*\$",
                            "error_message":
                                "Password must contain at least one uppercase letter",
                          },
                          {
                            "regex": "^(?=.*[a-z]).*\$",
                            "error_message":
                                "Password must contain at least one lowercase letter",
                          },
                          {
                            "regex": "^(?=.*\\d).*\$",
                            "error_message":
                                "Password must contain at least one digit",
                          },
                          {
                            "regex":
                                "^(?=.*[!@#\$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?~]).*\$",
                            "error_message":
                                "Password must contain at least one special character",
                          },
                        ],
                      },
                      {
                        "type": "checkbox",
                        "name": "remember_me",
                        "label": "Remember me",
                        "required": false,
                      },
                    ],
                    "submit": {
                      "type": "button",
                      "label": "Login",
                      "action": {
                        "type": "api_call",
                        "method": "POST",
                        "url": "https://jsonplaceholder.typicode.com/posts",
                        "success_message": "Login successful",
                        "error_message": "Login failed",
                      },
                    },
                  },
                  "Login Form",
                  successMessage: "Login successful",
                ),
                child: const Text("Login Form"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showForm(
                  {
                    "type": "form",
                    "title": "Contact Us",
                    "fields": [
                      {
                        "type": "text_input",
                        "name": "name",
                        "label": "Your Name",
                        "placeholder": "Enter your name",
                        "required": true,
                        "maxLength": 100,
                      },
                      {
                        "type": "email_input",
                        "name": "email",
                        "label": "Email Address",
                        "placeholder": "example@mail.com",
                        "required": true,
                      },
                      {
                        "type": "text_area",
                        "name": "message",
                        "label": "Message",
                        "placeholder": "Tell us how we can help you...",
                        "required": true,
                        "minLength": 10,
                        "maxLength": 500,
                      },
                      {
                        "type": "dropdown",
                        "name": "category",
                        "label": "Category",
                        "options": [
                          {"label": "Support", "value": "support"},
                          {"label": "Feedback", "value": "feedback"},
                          {"label": "General Inquiry", "value": "inquiry"},
                        ],
                        "required": true,
                      },
                    ],
                    "submit": {
                      "type": "button",
                      "label": "Send Message",
                      "action": {
                        "type": "api_call",
                        "method": "POST",
                        "url": "https://jsonplaceholder.typicode.com/posts",
                        "success_message": "Message sent successfully",
                        "error_message": "Failed to send message",
                      },
                    },
                    "reset": true,
                  },
                  "Contact Form",
                  successMessage: "Message sent successfully",
                ),
                child: const Text("Contact Form"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showForm(
                  {
                    "type": "form",
                    "title": "Product Feedback",
                    "fields": [
                      {
                        "type": "number_input",
                        "name": "rating",
                        "label": "Rating (1-5)",
                        "placeholder": "5",
                        "required": true,
                        "min": 1,
                        "max": 5,
                      },
                      {
                        "type": "text_area",
                        "name": "comments",
                        "label": "Comments",
                        "placeholder": "Share your thoughts...",
                        "required": false,
                        "maxLength": 300,
                      },
                      {
                        "type": "dropdown",
                        "name": "product",
                        "label": "Product",
                        "options": [
                          {"label": "App", "value": "app"},
                          {"label": "Website", "value": "website"},
                          {"label": "Service", "value": "service"},
                        ],
                        "required": true,
                      },
                      {
                        "type": "checkbox",
                        "name": "anonymous",
                        "label": "Submit anonymously",
                        "required": false,
                      },
                    ],
                    "submit": {
                      "type": "button",
                      "label": "Submit Feedback",
                      "action": {
                        "type": "api_call",
                        "method": "POST",
                        "url": "https://jsonplaceholder.typicode.com/posts",
                        "success_message": "Feedback submitted",
                        "error_message": "Failed to submit feedback",
                      },
                    },
                  },
                  "Feedback Form",
                  successMessage: "Feedback submitted successfully",
                ),
                child: const Text("Feedback Form"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
