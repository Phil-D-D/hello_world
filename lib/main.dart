import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/login_page/login_page.dart';
import 'package:hello_world/models/link_data.dart';
import 'package:hello_world/not_found_page.dart';
import 'package:hello_world/settings_pge/setting_page.dart';
import 'package:provider/provider.dart';
import 'links_landing_page/links_landing_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseFirestore.instance.settings = Settings(
  //   host: "localhost:8080",
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final linksCollection = FirebaseFirestore.instance.collection("links");
    final userLinkDataStream = linksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LinkData.fromDocument(doc);
      }).toList();
    });
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
        Provider<CollectionReference>(
          create: (context) => linksCollection,
        ),
        StreamProvider<List<LinkData>>(
          create: (context) => userLinkDataStream,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: (settings) {
          print(settings.name);
          return MaterialPageRoute(builder: (context) {
            return RouteController(settingsName: settings.name);
          });
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return NotFoundPage();
            },
          );
        },
      ),
    );
  }
}

class RouteController extends StatelessWidget {
  final String settingsName;

  const RouteController({
    Key key,
    @required this.settingsName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSignedIn = Provider.of<User>(context) != null;
    final notSignedInGoSettings = !userSignedIn && settingsName == "/settings";
    final signedInGoSettings = userSignedIn && settingsName == "/settings";

    if (settingsName == "/") {
      return LinksLandingPage();
    } else if (notSignedInGoSettings || settingsName == "/login") {
      return LoginPage();
    } else if (signedInGoSettings) {
      return SettingsPage();
    } else {
      return NotFoundPage();
    }
  }
}
