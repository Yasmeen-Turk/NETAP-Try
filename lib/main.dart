import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netap/page/home_page.dart';
import 'package:flutter_netap/page/location.dart';
import 'package:flutter_netap/screens/instructor_home.dart';
import 'package:flutter_netap/screens/usertype.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_netap/provider/checkProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CheckProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ONETAP',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(0, 132, 188, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserTypeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
