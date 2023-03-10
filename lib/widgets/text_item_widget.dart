import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  String label = "";

  TextItem({Key? key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
