
import 'package:flutter/material.dart';

import 'package:final_project_biblical_reference/common/strings.dart' as strings;

import 'reference_from_paraphrase.dart';
import 'passage_of_reference.dart';
import 'commentary_for_passage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Indexul chat-ului selectat
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    //Cele trei variante de chat
    ReferenceFromParaphrase(),
    PassageOfReference(),
    CommentaryForPassage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      //Chat-ul selectat
      body: _widgetOptions.elementAt(_selectedIndex),

      //Bara de navigare
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Reference',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_rounded),
            label: 'Passage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_rounded),
            label: 'Commentary',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
