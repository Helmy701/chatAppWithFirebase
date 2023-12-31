import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/screens/Login_Screen.dart';
import 'package:test/screens/chat_Page.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/register_Screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ChatPage.id: (context) => ChatPage(),
        HomeScreen.id: (context) => HomeScreen(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff2B475E),
      ),
      initialRoute: 'LoginPage',
    );
  }
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
