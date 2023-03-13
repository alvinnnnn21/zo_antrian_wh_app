// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/providers/work_in_progress_provider.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/input_widget.dart';

class InputPengeluaranPage extends StatefulWidget {
  const InputPengeluaranPage({Key? key}) : super(key: key);

  @override
  State<InputPengeluaranPage> createState() => _InputPengeluaranPageState();
}

class _InputPengeluaranPageState extends State<InputPengeluaranPage> {
  var nominalController = TextEditingController();
  var keteranganController = TextEditingController();
  bool isLoading = false;
  final storage = GetStorage();

  void initState() {
    Timer(Duration(seconds: 0), () {
      getInit();
    });
    super.initState();
  }

  getInit() {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print("data $data");

    if (data["type"] == "edit") {
      nominalController.text = data["nominal"];
      keteranganController.text = data["purpose"];
    }
  }

  @override
  Widget build(BuildContext context) {
    WorkInProgressProvider workProvider =
        Provider.of<WorkInProgressProvider>(context);
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    handleAddPengeluaran() async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");

      if (int.parse(data["total_uang_saku"].replaceAll(".", "")) <
          int.parse(nominalController.text.replaceAll(".", ""))) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content: Text("Pengeluaran Melebihi Total Uang Saku",
                textAlign: TextAlign.center)));
      } else if (int.parse(data["total_uang_saku"].replaceAll(".", "")) >=
          int.parse(nominalController.text.replaceAll(".", ""))) {
        dynamic response = await workProvider.AddPocketMoney(
            token: token,
            nominal: nominalController.text.replaceAll(".", ""),
            keterangan: keteranganController.text,
            id: data["idWip"].toString());

        if (response == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xff00b212),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 3),
              content: Text("Berhasil Menambah Pengeluaran",
                  textAlign: TextAlign.center)));
          Navigator.pop(context);
          // Navigator.popAndPushNamed(context, data["from"],
          //     arguments: data["idWip"]);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 3),
              content: Text(response, textAlign: TextAlign.center)));
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    handleEditPengeluaran() async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");

      if (int.parse(data["total_uang_saku"].replaceAll(".", "")) +
              int.parse(data["nominal"].replaceAll(".", "")) <
          int.parse(nominalController.text.replaceAll(".", ""))) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content: Text("Pengeluaran Melebihi Total Uang Saku",
                textAlign: TextAlign.center)));
      } else if (int.parse(data["total_uang_saku"].replaceAll(".", "")) +
              int.parse(data["nominal"].replaceAll(".", "")) >=
          int.parse(nominalController.text.replaceAll(".", ""))) {
        dynamic response = await workProvider.EditPocketMoney(
            token: token,
            nominal: nominalController.text.replaceAll(".", ""),
            keterangan: keteranganController.text,
            id: data["idPengeluaran"].toString());

        if (response == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xff00b212),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 3),
              content: Text("Berhasil Edit Pengeluaran",
                  textAlign: TextAlign.center)));
          Navigator.pop(context);
          // Navigator.popAndPushNamed(context, data["from"],
          //     arguments: data["idWip"]);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 3),
              content: Text(response, textAlign: TextAlign.center)));
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            shadowColor: Colors.white,
            backgroundColor: Color(0xff5493CA),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left,
                    size: 40, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '${data["type"] == "input" ? "Input" : "Edit"} Pengeluaran',
              style: TextStyle(color: Colors.white),
            )),
        body: isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                          scale: 2,
                          child: CircularProgressIndicator(
                              color: Color(0xff2a78be)))
                    ]))
            : SafeArea(
                child: Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Input(
                        label: 'Nominal : ',
                        controller: nominalController,
                        type: "number",
                        width: double.infinity),
                    SizedBox(height: 30),
                    Input(
                        label: 'Keterangan : ',
                        controller: keteranganController,
                        width: double.infinity),
                    SizedBox(height: 40),
                    Button(
                        isLoading: false,
                        title: "SIMPAN",
                        onPressed: data["type"] == "input"
                            ? handleAddPengeluaran
                            : handleEditPengeluaran,
                        width: double.infinity,
                        textColor: Colors.white,
                        bgColor: Color(0xff33995E),
                        borderColor: Color(0xff33995E),
                        height: 45)
                  ],
                )),
              )));
  }
}
