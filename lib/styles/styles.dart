import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/styles/theme.dart';

TextStyle transactionOpt() {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 12.16,
    height: 1.7,
    color: AppColors.secondaryColor,
  );
}

TextStyle welcomeText({color}) {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.7,
    color: color,
  );
}

TextStyle smallText() {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 1.2,
    color: Color(0xffA1A1A1),
  );
}

TextStyle bodyText({color}) {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.2,
    color: color,
  );
}

TextStyle ccNumber({color}) {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w100,
    fontSize: 10,
    color: Colors.white,
  );
}

TextStyle amountStyle({color}) {
  return GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 35,
    color: color,
  );
}
