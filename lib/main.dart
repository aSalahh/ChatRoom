import 'package:chat_app/view/pages/chat_page.dart';
import 'package:chat_app/view/pages/login_page.dart';
import 'package:chat_app/view/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
   ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id:(context)=>ChatPage()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
    );
  }
}
