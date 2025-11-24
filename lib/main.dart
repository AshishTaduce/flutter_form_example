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
          FormGenerator(
            formData: formData,
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
              print("Submitted Values: $values");
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
                    "title": "Comprehensive Test Form",
                    "fields": [
                      // Row 1: Name and Email
                      [
                        {
                          "type": "text_input",
                          "name": "full_name",
                          "label": "Full Name",
                          "required": true,
                          "tooltip": "Enter your legal name",
                        },
                        {
                          "type": "email_input",
                          "name": "email",
                          "label": "Email",
                          "required": true,
                        }
                      ],
                      // Row 2: Date and Time
                      [
                        {
                          "type": "date",
                          "name": "dob",
                          "label": "Date of Birth",
                          "required": true,
                        },
                        {
                          "type": "time",
                          "name": "slot",
                          "label": "Preferred Time",
                          "required": true,
                        }
                      ],
                      // Row 3: Country (Searchable Dropdown)
                      {
                        "type": "dropdown",
                        "name": "country",
                        "label": "Country",
                        "options": [
                          {"label": "United States", "value": "USA"},
                          {"label": "India", "value": "IND"},
                          {"label": "Canada", "value": "CAN"},
                          {"label": "United Kingdom", "value": "UK"},
                        ],
                        "required": true,
                        "isSearchable": true,
                        "hint": "Select your country of residence",
                      },
                      // Row 4: State (Dependent on Country == USA)
                      {
                        "type": "dropdown",
                        "name": "state",
                        "label": "State",
                        "options": [
                          {"label": "California", "value": "CA"},
                          {"label": "New York", "value": "NY"},
                          {"label": "Texas", "value": "TX"},
                        ],
                        "enabledIf": {
                          "field": "country",
                          "operator": "==",
                          "value": "USA"
                        }
                      },
                      // Row 5: Gender (Radio)
                      {
                        "type": "radio",
                        "name": "gender",
                        "label": "Gender",
                        "options": [
                          {"label": "Male", "value": "male"},
                          {"label": "Female", "value": "female"},
                          {"label": "Other", "value": "other"},
                        ],
                        "required": true,
                      },
                      // Row 6: Resume (File)
                      {
                        "type": "file",
                        "name": "resume",
                        "label": "Upload Resume",
                        "required": true,
                      },
                      // Row 7: Terms (Checkbox)
                      {
                        "type": "checkbox",
                        "name": "terms",
                        "label": "I agree to Terms",
                        "required": true,
                      }
                    ],
                    "submit": {
                      "label": "Register",
                      "action": {
                        "type": "api_call",
                        "method": "POST",
                        "url": "https://jsonplaceholder.typicode.com/posts",
                        "success_message": "Form Submitted!",
                      }
                    },
                    "reset": true,
                  },
                  "Test Form",
                ),
                child: const Text("Test New Features"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
