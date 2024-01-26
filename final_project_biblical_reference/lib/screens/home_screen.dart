
import 'package:flutter/material.dart';

import 'package:final_project_biblical_reference/common/strings.dart' as strings;

import 'package:dart_openai/dart_openai.dart';
import 'package:final_project_biblical_reference/env/env.dart' as env;

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
  String? response;

  void getReferenceAPI(data) async {
    OpenAI.apiKey = env.apiKey;

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          data
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [userMessage],
    );

    //print(chatCompletion.choices.single.message.content?.first.text);
    
    setState(() {
      response = chatCompletion.choices.single.message.content?.first.text;
    });

  }

  @override
  Widget build(BuildContext context) {

    ThemeData tema = Theme.of(context);

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
                  // Validate will return true if the form is valid, or false if the form is invalid
                  if (_formKey.currentState!.validate()) {
                    data = _textController.text;

                    getReferenceAPI(data);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ),
          Visibility(
            visible:  response != null,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: tema.colorScheme.secondary, // Culoarea de fundal a containerului
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: tema.colorScheme.primary,
                  width: 3.0,
                ),
              ),
              child: Text(
                response ?? '',
              style: TextStyle(color: tema.colorScheme.onSecondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
