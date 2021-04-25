import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final region = arguments['region'].toString();
    final name = arguments['name'].toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 3,
        title: Text(
          "HelPet - צ'אט  ${arguments['region'].toString() ?? ""}",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: Image.asset('lib/assets/helpet.png'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  color: Colors.brown[200],
                  child: Container(
                    width: 135,
                    height: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "הוסף צ'אט חדש",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    Navigator.pushNamed(context, '/newmessage',
                        arguments: {'name': name, 'region': region})
                  },
                ),
              ],
            ),
          ),
          // Text(arguments['region'].toString() ?? ""),
          // Text(arguments['name'].toString() ?? ""),
        ],
      ),
    );
  }
}
