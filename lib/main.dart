import 'package:bootcamp/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RootClass());
}

class RootClass extends StatelessWidget {
  const RootClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
