import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    final handled = arguments['handled'].toString();

    String formattedDate = arguments['date'].toString();

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
      body: Container(
        child: Row(
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
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  // color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          handled == 'לא טופל'
                              ? FlatButton(
                                  color: Colors.brown[300],
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "האם הנושא טופל?",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _handledTopic(region, id);
                                    Navigator.popAndPushNamed(context, '/chat',
                                        arguments: {
                                          'name': name,
                                          'region': region
                                        });
                                  },
                                )
                              : Text(""),
                        ],
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'נוצר בתאריך: ' + formattedDate,
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.timer,
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
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Messages(region, id),
                ),
                Reply(name, region, id),
                FlatButton(
                  color: Colors.brown[300],
                  child: Container(
                    width: 135,
                    height: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        Text(
                          "חזור אחורה",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _errorTextField = null;
                    });
                    Navigator.popAndPushNamed(context, '/chat',
                        arguments: {'name': name, 'region': region});
                  },
                ),
              ],
            ),
          ],
        ),
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
var _errorTextField = '';
var handled = 'לא טופל';

Future<void> _sendMessage(String name, String id, String region) async {
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
  _enteredMessage = '';
  _controller.clear();
}

Future<void> _handledTopic(String region, String id) async {
  await Firestore.instance
      .collection('Chats')
      .document(region)
      .collection('chats_' + region)
      .document(id)
      .updateData({
    'handled': 'טופל',
  });
}

class _ReplyState extends State<Reply> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.1,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'שלח הודעה',
              errorText: _errorTextField,
              errorStyle: null,
              labelStyle: TextStyle(
                color: Colors.brown[300],
              ),
            ),
            onChanged: (value) {
              if (value.length == 0) {
                setState(() {
                  _enteredMessage = null;
                  _errorTextField = 'אנא כתוב תו אחד לפחות';
                });
              } else if (value.length <= 72 && value.length > 0) {
                setState(() {
                  _errorTextField = null;
                  _enteredMessage = value;
                });
              } else {
                setState(() {
                  _enteredMessage = '';
                  _errorTextField = 'אורך הודעה הוא 72 תווים לכל היותר.';
                });
              }
            },
          ),
          IconButton(
            color: Colors.brown[300],
            icon: Icon(
              Icons.send,
            ),
            onPressed: () => _enteredMessage.trim().isEmpty
                ? null
                : _sendMessage(widget.name, widget.id, widget.region),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages(this.region, this.id, {Key key}) : super(key: key);

  final String id;
  final String region;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('Chats')
              .document(region)
              .collection('chats_' + region)
              .document(id)
              .collection('replies')
              .orderBy(
                'Date',
              )
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.documents;
            int i = -1;
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                color: Colors.brown[300],
                // borderRadius: BorderRadius.circular(12),
              ),
              child: new ListView(
                  children: chatDocs.map<Widget>((DocumentSnapshot chat) {
                i++;
                return new MessageListTile(
                  i,
                  chat['Text'].toString(),
                  chat['creatorName'].toString(),
                  chat['Date'],
                );
              }).toList()),
            );
          }),
    );
  }
}

class MessageListTile extends StatelessWidget {
  const MessageListTile(this.index, this.text, this.creatorName, this.date,
      {Key key})
      : super(key: key);
  final int index;
  final String text;
  final String creatorName;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    var dateToShow = date.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(dateToShow);

    // var dateShow = DateTime.Format

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      color: index % 2 == 0 ? Colors.brown[300] : Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(text),
              ),
              Text(
                ' :' + "$creatorName",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text('נשלח ב: '),
              Text(formattedDate.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
