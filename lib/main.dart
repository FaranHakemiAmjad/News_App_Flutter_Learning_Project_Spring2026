import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_app/ui/tabs_screen/view/tabs_view.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsView(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 255, 174, 8), brightness: Brightness.light),

        textTheme: GoogleFonts.zainTextTheme(),
      ),
    );
  }
}