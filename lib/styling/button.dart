import 'package:flutter/material.dart';

class StyledButton {
  final double borderRadius;
  final int color;
  final double padding;
  StyledButton(
      {required this.borderRadius, required this.color, required this.padding});

  ButtonStyle customStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding));
  }
}
