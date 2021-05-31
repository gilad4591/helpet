import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class NewMessage extends StatelessWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final String region = arguments['region'].toString();
    final String name = arguments['name'].toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 3,
        title: Text(
          "HelPet - הוספת צ'אט חדש",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: Image.asset('lib/assets/helpet.png'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: TextFieldsEditor(name, region),
      ),
    );
  }
}

class TextFieldsEditor extends StatefulWidget {
  const TextFieldsEditor(this.name, this.region, {Key key}) : super(key: key);
  final String name;
  final String region;

  @override
  _TextFieldsEditorState createState() => _TextFieldsEditorState();
}

class _TextFieldsEditorState extends State<TextFieldsEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "הוסף צ'אט חדש",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        name: "Subject",
                        // lableText: "נושא",
                      ),
                    ),
                    Text("נושא"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                // FormBuilderDropdown(attribute: 'Sites', items: sites)
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        name: "City",
                        // lableText: "עיר",
                      ),
                    ),
                    Text("עיר   "),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                // FormBuilderDropdown(attribute: 'Sites', items: sites)
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        name: "Text",
                        // lableText: "טקסט",
                        multiline: true,
                      ),
                    ),
                    Text("טקסט"),
                  ],
                ),
                // FormBuilderDropdown(attribute: 'Sites', items: sites)

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  children: [
                    FlatButton(
                      color: Colors.brown[300],
                      child: Container(
                        width: 135,
                        height: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              "שלח",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.saveAndValidate()) {
                          await saveOnFirebase(widget.name, widget.region,
                              _formKey.currentState.value);
                          Navigator.pushNamed(context, '/chat', arguments: {
                            'name': widget.name,
                            'region': widget.region
                          });
                        }
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
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
                        Navigator.popAndPushNamed(context, '/chat', arguments: {
                          'name': widget.name,
                          'region': widget.region
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveOnFirebase(String name, String region, var values) async {
    var today = new DateTime.now();
    await Firestore.instance
        .collection('Chats')
        .document(region)
        .collection('chats_' + region)
        .add({
      'City': values['City'].toString(),
      'Date': today,
      'Text': values['Text'].toString(),
      'Subject': values['Subject'].toString(),
      'creatorName': name,
      'handled': 'לא טופל',
    });
  }
}

class TextField extends StatelessWidget {
  final String name;
  final String lableText;
  final bool multiline;
  const TextField({
    Key key,
    @required this.name,
    this.lableText,
    this.multiline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            // textInputAction: TextInputAction.newline,
            // expands: true,
            // keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 4,
            inputFormatters: [],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: lableText,
            ),
            attribute: name,
            validators: [
              FormBuilderValidators.maxLength(72,
                  errorText: 'אורך הודעה לא יעלה על 72 תווים'),
              FormBuilderValidators.required(
                  errorText: 'שדה זה אינו יכול להשאר ריק'),
            ],
          ),
        ),
      ],
    );
  }
}

// in the same i will add all the pages.... now...

// ok i have added it
