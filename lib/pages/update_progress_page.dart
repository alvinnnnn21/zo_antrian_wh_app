// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/providers/work_in_progress_provider.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/input_widget.dart';

class UpdateProgressPage extends StatefulWidget {
  const UpdateProgressPage({Key? key}) : super(key: key);

  @override
  State<UpdateProgressPage> createState() => _UpdateProgressPageState();
}

class _UpdateProgressPageState extends State<UpdateProgressPage> {
  bool isCheckedSampai = false;
  bool isCheckedMulai = false;
  bool isCheckedSelesai = false;
  bool isLoading = false;
  String progress = "";
  var keteranganController = TextEditingController();
  final storage = GetStorage();

  void initState() {
    Timer(Duration(seconds: 0), () {
      getInit();
    });
  }

  getInit() {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      isCheckedSampai = data["task"].sampai == "-" ? false : true;
      isCheckedMulai = data["task"].mulai == "-" ? false : true;
      isCheckedSelesai = data["task"].selesai == "-" ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    WorkInProgressProvider workProvider =
        Provider.of<WorkInProgressProvider>(context);
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    bool handleDisabled(String type) {
      if (type == "mulai") {
        if (data["task"].sampai == "-")
          return true;
        else if (data["task"].sampai != "-" && isCheckedMulai) return true;
        return false;
      } else if (type == "selesai") {
        if ((data["task"].sampai == "-" || data["task"].mulai == "-") ||
            isCheckedSelesai) {
          return true;
        } else if (data["task"].sampai != "-" && data["task"].mulai != "-") {
          if (isCheckedSelesai) {
            return true;
          } else {
            return false;
          }
        }
      }

      if (type == "sampai") {
        if (isCheckedSampai) {
          return true;
        }
      }

      return false;
    }

    // handleUpdateProgress() async {
    //   setState(() {
    //     isLoading = true;
    //   });

    //   final token = storage.read("token");

    //   dynamic response = await workProvider.UpdateProgress(
    //       token: token,
    //       progress: progress,
    //       keterangan: keteranganController.text,
    //       id: data["idTask"].toString());

    //   if (response == true) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: Color(0xff00b212),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    //         duration: Duration(seconds: 2),
    //         content:
    //             Text("Berhasil Update Progress", textAlign: TextAlign.center)));

    //     Navigator.popAndPushNamed(context, "/work-in-progress",
    //         arguments: int.parse(data["idWip"]));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: Color(0xffff0000),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    //         duration: Duration(seconds: 2),
    //         content: Text(response, textAlign: TextAlign.center)));
    //   }
    // }

    // handleHapusRute() async {
    //   setState(() {
    //     isLoading = true;
    //   });

    //   final token = storage.read("token");

    //   dynamic response = await workProvider.HapusRute(
    //       token: token,
    //       keterangan: keteranganController.text,
    //       id: data["idTask"].toString());

    //   if (response == true) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: Color(0xff00b212),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    //         duration: Duration(seconds: 2),
    //         content: Text("Berhasil Hapus Rute", textAlign: TextAlign.center)));

    //     Navigator.popAndPushNamed(context, "/work-in-progress",
    //         arguments: int.parse(data["idWip"]));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: Color(0xffff0000),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
    //         duration: Duration(seconds: 2),
    //         content: Text(response, textAlign: TextAlign.center)));
    //   }
    // }

    Widget Item(Color color, int index, Task task) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: color,
              border: Border.all(width: 0.8, color: const Color(0xff808080))),
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 30,
                child: Text(index.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(index.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text(task.status,
                          style: const TextStyle(fontWeight: FontWeight.w700))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(task.perusahaan,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Column(
                      // children: task.task_list
                      //     .map((item) => Container(
                      //           margin: const EdgeInsets.only(top: 5),
                      //           child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Container(
                      //                     width: 200, child: Text(item.item)),
                      //                 Container(child: Text(item.weight)),
                      //               ]),
                      //         ))
                      //     .toList(),
                      ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Total ${task.total_item} item',
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        Text('${task.total_weight}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ]),
                ],
              ),
            ),
          ]));
    }

    Widget CustomCheckbox(String label, bool isChecked,
        onChanged(bool? checkBoxState), bool disabled) {
      return Column(children: [
        Transform.scale(
            scale: 2.5,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color(0xffcccccc);
                }
                return Colors.white;
              }),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(width: 0.5, color: Color(0xff808080))),
              activeColor: Colors.white,
              checkColor: const Color(0xff14181b),
              value: isChecked,
              onChanged: disabled ? null : onChanged,
            )),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500))
      ]);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left,
                    size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text(
              "Update Progress",
              style: TextStyle(color: Colors.black),
            )),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Item(const Color(0xffffffd2), 1, data["task"]),
              Button(
                  isLoading: false,
                  title: "Hapus Rute",
                  bgColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 14,
                  height: 40,
                  width: 100,
                  onPressed: () {}),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCheckbox("Sampai", isCheckedSampai,
                          (bool? checkBoxState) {
                        setState(() => {
                              progress = progress == "" ? "sampai" : "",
                              isCheckedSampai = !isCheckedSampai
                            });
                      }, handleDisabled("sampai")),
                      CustomCheckbox("Mulai", isCheckedMulai,
                          (bool? checkBoxState) {
                        setState(() => {
                              progress = progress == "" ? "mulai" : "",
                              isCheckedMulai = !isCheckedMulai
                            });
                      }, handleDisabled("mulai")),
                      CustomCheckbox("Selesai", isCheckedSelesai,
                          (bool? checkBoxState) {
                        setState(() => {
                              progress = progress == "" ? "selesai" : "",
                              isCheckedSelesai = !isCheckedSelesai
                            });
                      }, handleDisabled("selesai")),
                    ]),
              ),
              const SizedBox(height: 60),
              Input(
                width: double.infinity,
                label: 'Keterangan :',
                controller: keteranganController,
              ),
              const SizedBox(height: 20),
              Button(
                  isLoading: false,
                  title: "SIMPAN",
                  onPressed: () {},
                  width: double.infinity,
                  textColor: Colors.white,
                  height: 70)
            ],
          )),
        )));
  }
}
