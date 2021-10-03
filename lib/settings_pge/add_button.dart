import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/link_data.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    final _linksCollection = Provider.of<CollectionReference>(context);
    TextEditingController _titleTextController = TextEditingController();
    TextEditingController _urlTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return SizedBox(
      width: width,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add new button"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty ? "Please add in a title" : null;
                        },
                        controller: _titleTextController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          hintText: "Facebook",
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty ? "Please add in a url" : null;
                        },
                        controller: _urlTextController,
                        decoration: InputDecoration(
                          labelText: "URL",
                          hintText: "https://",
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _linksCollection.add(
                            LinkData(
                                    title: _titleTextController.text,
                                    url: _urlTextController.text)
                                .toMap(),
                          );
                          Navigator.of(context).pop();
                          _formKey.currentState.reset();
                        }
                      },
                      child: Text("Add")),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _formKey.currentState.reset();
                      },
                      child: Text("Cancel")),
                ],
              );
            },
          );
        },
        child: Text("Add Button"),
        color: Colors.greenAccent.shade400,
      ),
    );
  }
}
