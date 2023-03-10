import 'package:flutter/material.dart';

class LabelList extends StatelessWidget {
  List label = [];
  List<Widget> value = [];
  String type = "";

  LabelList(
      {Key? key, required this.label, required this.value, this.type = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: type == "spaceBetween"
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: label
              .map((item) => Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(item,
                      style: TextStyle(fontWeight: FontWeight.w500))))
              .toList(),
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: type == "spaceBetween"
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: value
              .map((item) => Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: item))
              .toList(),
        )
      ],
    ));
  }
}
