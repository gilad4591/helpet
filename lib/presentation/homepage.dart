import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
String dropDown;

class HelPet extends StatefulWidget {
  HelPet({Key key}) : super(key: key);

  @override
  _HelPetState createState() => _HelPetState();
}

class _HelPetState extends State<HelPet> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(
                  'lib/assets/helpet.png',
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    //shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilder(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFieldsEditor(_formKey),
                            RaisedButton(
                                child: Text("כנס לצאט"),
                                onPressed: () {
                                  _formKey.currentState.saveAndValidate();
                                  if (_formKey.currentState.validate()) {
                                    String name = _formKey
                                        .currentState.value['ChatName']
                                        .toString();
                                    Navigator.pushNamed(context, '/chat',
                                        arguments: {
                                          'name': name,
                                          'region': dropDown
                                        });
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldsEditor extends StatefulWidget {
  const TextFieldsEditor(GlobalKey<FormBuilderState> formKey, {Key key})
      : super(key: key);

  @override
  _TextFieldsEditorState createState() => _TextFieldsEditorState();
}

List<String> sites = ['צפון', 'מרכז', 'דרום'];
List<DropdownMenuItem> items = [];
String dropDownValue;

class _TextFieldsEditorState extends State<TextFieldsEditor> {
  @override
  void initState() {
    super.initState();
    dropDown = 'דרום';
    dropDownValue = 'דרום';
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   dropDownValue = 'דרום';
    // });
    return Container(
      child: Column(children: [
        Text(
          "אנא בחר שם",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.1,
          child: TextField(
            name: "ChatName",
            lableText: 'שם בצאט',
          ),
        ),
        // FormBuilderDropdown(attribute: 'Sites', items: sites)
        DropdownButton(
          onChanged: (newValue) {
            setState(() {
              dropDownValue = newValue.toString();
              dropDown = dropDownValue;
            });
          },
          value: dropDownValue,
          items: sites.map((String site) {
            return (DropdownMenuItem(
              value: site,
              child: Text(site),
            ));
          }).toList(),
          hint: Text('אזור'),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ]),
    );
  }
}

class TextField extends StatelessWidget {
  final String name;
  final String lableText;
  const TextField({
    Key key,
    @required this.name,
    this.lableText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            inputFormatters: [],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: lableText,
            ),
            attribute: name,
            validators: [
              FormBuilderValidators.required(
                  errorText: 'שם חייב להכיל לפחות תו אחד'),
              FormBuilderValidators.maxLength(20,
                  errorText: 'שם לא יכול להיות ארוך 20 תווים'),
            ],
          ),
        ),
      ],
    );
  }
}

// in the same i will add all the pages.... now...

// ok i have added it
