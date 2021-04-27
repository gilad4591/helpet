import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExistsChat extends StatefulWidget {
  const ExistsChat({Key key}) : super(key: key);

  @override
  _ExistsChatState createState() => _ExistsChatState();
}

class _ExistsChatState extends State<ExistsChat> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final name = arguments['name'].toString();
    final id = arguments['id'].toString();
    final subject = arguments['subject'].toString();
    final city = arguments['city'].toString();
    final creatorName = arguments['creatorName'].toString();
    final messageText = arguments['text'].toString();
    final region = arguments['region'].toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 3,
        title: Text(
          "HelPet",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: Image.asset('lib/assets/helpet.png'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width * 0.5,
                // color: Colors.grey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'נוצר ע"י: ' + creatorName,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.create,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'עיר: ' + city,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'נושא: ' + subject,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.subject,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            messageText,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Messages(),
              // ),
              // Reply(name, region, id),
            ],
          ),
        ],
      ),
    );
  }
}

class Reply extends StatefulWidget {
  const Reply(this.name, this.region, this.id, {Key key}) : super(key: key);
  final String name;
  final String region;
  final String id;
  @override
  _ReplyState createState() => _ReplyState();
}

var _enteredMessage = '';
final _controller = new TextEditingController();

void _sendMessage(
  String name,
  String region,
  String id,
) async {
  await Firestore.instance
      .collection('Chats')
      .document(region)
      .collection('chats_' + region)
      .document(id)
      .collection('replies')
      .add({
    'Text': _enteredMessage,
    'Date': Timestamp.now(),
    'creatorName': name,
  });
  _controller.clear();
}

class _ReplyState extends State<Reply> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Send a message'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: () {},
            // onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage(widget.name, widget.id, widget.region),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("d");
  }
}
