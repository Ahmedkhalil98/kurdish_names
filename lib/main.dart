import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kurdish_names/src/screens/kurdish_names_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.notoNaskhArabic().fontFamily),
      home: KurdishNamesList(),
    );
  }
}
