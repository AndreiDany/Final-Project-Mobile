
import 'package:flutter/material.dart';

import 'package:final_project_biblical_reference/common/strings.dart' as strings;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(strings.appName,
            style: TextStyle(color: tema.colorScheme.onPrimary,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              )
            ),
        ),
        backgroundColor: tema.colorScheme.primary,
        
      ),
      body: Container(
        color: const Color(0xFFEEEEEE),
        child: const Padding(
          padding: EdgeInsets.only(top: 64.0, left: 32, right: 32),
          child: InputForParaphrase(),
        ),
      ),
    );
  }
}

class InputForParaphrase extends StatefulWidget {
  const InputForParaphrase({super.key});

  @override
  State<InputForParaphrase> createState() => _InputForParaphraseState();
}

class _InputForParaphraseState extends State<InputForParaphrase> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  String? data;


  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter the paraphrased Bible verse',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    data = _textController.text;

                    //print(data);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
