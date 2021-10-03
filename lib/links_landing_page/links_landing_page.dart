import 'package:flutter/material.dart';
import 'package:hello_world/models/link_data.dart';
import 'package:provider/provider.dart';
import 'button_Link.dart';
import '../constants.dart';
import 'footer.dart';

class LinksLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _documents = Provider.of<List<LinkData>>(context);
    if (_documents == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.transparent,
            radius: 48,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "@socialhandle",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(
            height: 12,
          ),
          if (_documents.isEmpty) Text("No Links to share :("),
          for (var document in _documents)
            ButtonLink(title: document.title, url: document.url),
          Spacer(),
          Footer(),
          SizedBox(
            height: 23,
          )
        ],
      ),
    );
  }
}
