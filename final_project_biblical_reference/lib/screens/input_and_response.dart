import 'package:flutter/material.dart';

//Cele necesare petru a lucra cu libraria dart_openai
import 'package:dart_openai/dart_openai.dart';
import 'package:final_project_biblical_reference/env/env.dart' as env;

class InputAndResponse extends StatefulWidget {
  final String query;
  const InputAndResponse({super.key, required this.query});

  @override
  // ignore: no_logic_in_create_state
  State<InputAndResponse> createState() => _InputAndResponseState(query: query);
}

class _InputAndResponseState extends State<InputAndResponse> {
  final String query;

  _InputAndResponseState({required this.query});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  String? data;
  String? response;
  bool isLoading = false;

  //Metoda care trimite intrebarea si primeste raspunsul de la OpenAI
  void getResponseFromOpenAPI(data) async {
    OpenAI.apiKey = env.apiKey;

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(query + data),
      ],
      role: OpenAIChatMessageRole.user,
    );

    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [userMessage],
    );

    //print(chatCompletion.choices.single.message.content?.first.text);
    setState(() {
      response = chatCompletion.choices.single.message.content?.first.text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter the text',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please a text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      data = _textController.text;

                      setState(() {
                        isLoading = true;
                      });

                      getResponseFromOpenAPI(data);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
      //Va fi vizibila una dintre cele doua: caseta text cu rapunsul sau indicatorul circular
      Visibility(
        visible: response != null,
        child: ResponseBox(response: response),
      ),
      Visibility(
          visible: isLoading == true,
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    ]);
  }
}

class ResponseBox extends StatelessWidget {
  const ResponseBox({
    super.key,
    required this.response,
  });

  final String? response;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Text(
          response ?? '',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
