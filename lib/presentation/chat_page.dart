import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Column(
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/newmessage',
                          arguments: {'name': name, 'region': region});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            // Text(arguments['region'].toString() ?? ""),
            // Text(arguments['name'].toString() ?? ""),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Chats')
                      .document(region)
                      .collection('chats_' + region)
                      .orderBy(
                        'Date',
                        // descending: true,
                      )
                      .snapshots(),
                  builder: (context, chatSnapshot) {
                    if (chatSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final chatDocs = chatSnapshot.data.documents;
                    int i = -1;
                    return Container(
                      child: new ListView(
                          children:
                              chatDocs.map<Widget>((DocumentSnapshot chat) {
                        i++;
                        return new MessageListTile(
                          i,
                          chat['Subject'].toString(),
                          chat['City'],
                          chat['Text'],
                          chat.documentID,
                          name,
                          region,
                          chat['creatorName'].toString(),
                          chat['Date'],
                        );
                      }).toList()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageListTile extends StatelessWidget {
  const MessageListTile(this.index, this.subject, this.city, this.text, this.id,
      this.myName, this.region, this.creatorName, this.date,
      {Key key})
      : super(key: key);
  final String id;
  final int index;
  final String subject;
  final String city;
  final String myName;
  final String region;
  final String text;
  final String creatorName;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    var dateToShow = date.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(dateToShow);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/existschat', arguments: {
          'name': myName,
          'region': region,
          'id': id,
          'subject': subject,
          'city': city,
          'creatorName': creatorName,
          'text': text,
          'date': formattedDate,
        });
      },
      child: Container(
        width: 600,
        height: 50,
        color: index % 2 == 0 ? Colors.brown[200] : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(city),
            Container(
              width: 150,
              child: Text(
                "$subject",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Text(formattedDate.toString()),
          ],
        ),
      ),
    );
  }
}
