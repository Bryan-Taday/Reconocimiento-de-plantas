import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/floresPage.dart';
import 'package:flutter_proyecto/loginemail.dart';
import 'package:flutter_proyecto/registerpage.dart';
import 'package:flutter_proyecto/resultados_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicia Sesión con Google',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'flores': (BuildContext context) => Flores(),
        'register': (BuildContext context) => RegisterPage(),
        //'results': (BuildContext context) => ResultadosPage(),
      },
    );
  }
}
