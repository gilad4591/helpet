import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class NewMessage extends StatelessWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

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
        body: FormBuilder(child: TextFieldsEditor(_formKey)));
  }
}

class TextFieldsEditor extends StatefulWidget {
  const TextFieldsEditor(GlobalKey<FormBuilderState> formKey, {Key key})
      : super(key: key);

  @override
  _TextFieldsEditorState createState() => _TextFieldsEditorState();
}

class _TextFieldsEditorState extends State<TextFieldsEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text("הוסף צ'אט חדש"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  name: "Subject",
                  lableText: "נושא",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // FormBuilderDropdown(attribute: 'Sites', items: sites)
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  name: "City",
                  lableText: "עיר",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // FormBuilderDropdown(attribute: 'Sites', items: sites)
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    // height: MediaQuery.of(context).size.height * 0.05,
                    child: TextField(
                      name: "Text",
                      lableText: "טקסט",
                      multiline: true,
                    ),
                  ),
                  Text("טקסט")
                ],
              ),
              // FormBuilderDropdown(attribute: 'Sites', items: sites)

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ]),
          ),
        ],
      ),
    );
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
          ),
        ),
      ],
    );
  }
}

// in the same i will add all the pages.... now...

// ok i have added it
