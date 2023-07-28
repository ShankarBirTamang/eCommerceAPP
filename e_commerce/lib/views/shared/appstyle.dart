import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size , Color color , FontWeight fWeight){
  return GoogleFonts.poppins(fontSize: size ,color : color , fontWeight: fWeight );
}
TextStyle appStyleWithHegiht(double size , Color color , FontWeight fWeight , double ht){
  return GoogleFonts.poppins(fontSize: size ,color : color , fontWeight: fWeight , height: ht );
}