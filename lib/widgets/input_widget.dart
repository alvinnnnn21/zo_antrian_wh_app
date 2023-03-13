import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  String label = "";
  bool obscureText = false;
  String type = "";
  TextEditingController controller = TextEditingController();
  Function() onPressed = () {};

  double width = 0.0;
  double height = 0.0;

  Input(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.type = "text",
      required this.controller,
      this.width = 250,
      this.height = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextFormField(
                obscureText: obscureText,
                // validator: validator,
                keyboardType:
                    type == "text" ? TextInputType.text : TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))))
          ],
        ));
  }
}
