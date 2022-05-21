
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldDapp extends StatelessWidget {
  
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLine;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  const FormFieldDapp({
    this.controller, 
    this.hintText, 
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLine = 1,
    this.readOnly = false,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      obscureText: isPassword,
      maxLines: maxLine,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.black26)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.black26)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
       // enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black45)),
        contentPadding: EdgeInsets.only(left: 15.0),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey),
      ),
      validator: validator,
    );
  }
}