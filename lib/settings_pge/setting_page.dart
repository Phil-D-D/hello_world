import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/settings_pge/preview_section.dart';

import 'buttons_settings_section.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton.icon(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.logout),
              label: Text("sign out"))
        ],
      ),
      body: Row(
        children: [
          ButtonsSettingsSections(),
          PreviewSection(),
        ],
      ),
    );
  }
}
