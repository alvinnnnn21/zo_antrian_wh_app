import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/widgets/text_item_widget.dart';

class Info extends StatelessWidget {
  Map<String, dynamic> info = {};
  bool isCard = false;
  Function() onPressed = () {};

  Info(
      {Key? key,
      required this.info,
      this.isCard = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(isCard ? 10 : 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isCard ? 15 : 0),
            border: Border.all(color: isCard ? Colors.black : Colors.white)),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                child: TextItem(label: "Sopir"),
              ),
              TableCell(
                child: TextItem(label: info["sopir"]),
              ),
              TableCell(
                child: TextItem(label: "Kernet"),
              ),
              TableCell(
                child: TextItem(label: info["kernet"]),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: TextItem(label: "Armada"),
              ),
              TableCell(
                child: TextItem(label: info["armada"]),
              ),
              TableCell(
                child: TextItem(label: "Nopol"),
              ),
              TableCell(
                child: TextItem(label: info["nopol"]),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: TextItem(label: "Rate"),
              ),
              TableCell(
                child: TextItem(label: info["rate"]),
              ),
              TableCell(
                child: TextItem(label: "Customer"),
              ),
              TableCell(
                child: TextItem(label: info["customer"]),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: TextItem(label: "Kapasitas"),
              ),
              TableCell(
                child: TextItem(label: info["kapasitas"]),
              ),
              TableCell(
                child: SizedBox.shrink(),
              ),
              TableCell(
                child: SizedBox.shrink(),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: TextItem(label: "Tonase"),
              ),
              TableCell(
                child: TextItem(label: info["tonase"]),
              ),
              TableCell(
                child: SizedBox.shrink(),
              ),
              TableCell(
                child: SizedBox.shrink(),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
