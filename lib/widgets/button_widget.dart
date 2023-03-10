import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String title = "";
  double width = 0.0;
  double height = 0.0;
  double fontSize = 0.0;
  FontWeight fontWeight = FontWeight.w600;
  Color textColor = Colors.black;
  Color bgColor = Colors.black;
  Color borderColor = Colors.black;
  bool isLoading = false;
  bool isDisabled = false;
  Function() onPressed = () {};

  Button(
      {Key? key,
      required this.title,
      this.width = 250,
      this.height = 50,
      required this.onPressed,
      this.textColor = Colors.black,
      this.fontSize = 20,
      this.bgColor = Colors.black,
      this.borderColor = Colors.black,
      this.fontWeight = FontWeight.w600,
      required this.isLoading,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: TextButton(
          style: ButtonStyle(
              // backgroundColor: MaterialStatePropertyAll<Color>(bgColor),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Color(0xffE1E1E1);
                }
                return bgColor;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                          color:
                              isDisabled ? Color(0xffE1E1E1) : borderColor)))),
          child: isLoading
              ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: textColor))
              : Text(
                  title,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                ),
          onPressed: isDisabled
              ? null
              : isLoading
                  ? null
                  : onPressed,
        ));
  }
}
