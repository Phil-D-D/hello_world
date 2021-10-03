import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonLink extends StatelessWidget {
  final String title;
  final String url;

  const ButtonLink({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: width > 680 ? 680 : width * 0.95,
          child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 25),
            onPressed: () => launch(url),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            color: Colors.tealAccent,
          ),
        ),
      );
    });
  }
}
