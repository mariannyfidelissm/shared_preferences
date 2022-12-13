import 'package:flutter/material.dart';
import '../services/shared.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPref sharedPrefs = SharedPref();

  @override
  void initState() {
    super.initState();

    //É possível aguardar uma lista de serviços antes do início da aplicação
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Future.wait([
        sharedPrefs.isAuth(),
      ]).then((value) {
        if (value[0]) {
          debugPrint(value[0].toString());
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false,
              arguments: {'prefs': sharedPrefs});
        } else {
          Navigator.of(context)
              .pushNamed('/shared', arguments: {'prefs': sharedPrefs});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
