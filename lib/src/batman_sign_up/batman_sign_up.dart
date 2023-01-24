import 'package:concept_designs/src/batman_sign_up/batman_home_page.dart';
import 'package:concept_designs/src/common.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BatmanSignUp extends StatelessWidget {
  const BatmanSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Theme(
      data: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.vidalokaTextTheme(),
      ),
      child: const BatmanHomePage(),
    );
  }
}
