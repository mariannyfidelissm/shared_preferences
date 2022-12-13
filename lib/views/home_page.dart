import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/views/preferences_page.dart';

import '../services/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPref sharedPref;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, SharedPref>;
    if (args != null) {
      sharedPref = args["prefs"] ?? SharedPref();
    } else {
      sharedPref = SharedPref();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () async {
                await SharedPreferences.getInstance()
                    .then((value) => value.remove('isLoggedIn'));
                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .pushNamed('/shared', arguments: {'prefs': sharedPref});
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Container(
          color: Colors.deepPurple,
          child: const Center(
              child: Text('Home Page',
                  style: TextStyle(fontSize: 25, color: Colors.white)))),
    );
  }
}
