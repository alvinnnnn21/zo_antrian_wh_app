// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/models/work_in_progress_model.dart';
import 'package:sutindo_supir_app/providers/work_in_progress_provider.dart';
import 'package:sutindo_supir_app/theme.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/input_widget.dart';

class WorkInProgressPage extends StatefulWidget {
  const WorkInProgressPage({Key? key}) : super(key: key);

  @override
  State<WorkInProgressPage> createState() => _WorkInProgressPageState();
}

class _WorkInProgressPageState extends State<WorkInProgressPage> {
  final storage = GetStorage();
  bool isLoading = true;
  List<TextEditingController> list_controller = [];
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> list_checkbox = [];
  List<String> list_progress = [];

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      getInit();
    });
    super.initState();
  }

  getInit() async {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    final String token = storage.read("token");
    dynamic response =
        await Provider.of<WorkInProgressProvider>(context, listen: false)
            .GetWorkInProgress(token: token, id: id);

    WorkInProgress wip =
        Provider.of<WorkInProgressProvider>(context, listen: false).work;

    for (var i = 0; i < wip.list_task.length; i++) {
      var task = wip.list_task[i];

      TextEditingController _controller = TextEditingController();
      list_controller.add(_controller);
      list_checkbox.add({
        "sampai": task.progress_eksternal >= 2 ? true : false,
        "mulai": task.progress_eksternal >= 3 ? true : false,
        "selesai": task.progress_eksternal >= 4 ? true : false
      });
      list_progress.add("-");
    }

    setState(() {
      isLoading = false;
    });

    if (response != true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xffff0000),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
          duration: Duration(seconds: 3),
          content: Text(response, textAlign: TextAlign.center)));
    }
  }

  @override
  Widget build(BuildContext context) {
    WorkInProgressProvider workProvider =
        Provider.of<WorkInProgressProvider>(context);
    int id = ModalRoute.of(context)!.settings.arguments as int;

    handleUpdateProgress(String progress, String keterangan, String id,
        String customer, int index, int no_urut) async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");

      dynamic response = await workProvider.UpdateProgress(
          token: token,
          progress: progress,
          keterangan: keterangan,
          id: id,
          customer: customer,
          no_urut: no_urut);

      setState(() {
        isLoading = false;
      });

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff00b212),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content:
                Text("Berhasil Update Progress", textAlign: TextAlign.center)));

        getInit();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content: Text(response, textAlign: TextAlign.center)));
      }
    }

    handleHapusRute(
        String keterangan, String id, String customer, String no_urut) async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");

      dynamic response = await workProvider.HapusRute(
          token: token,
          keterangan: keterangan,
          id: id,
          customer: customer,
          no_urut: no_urut);

      setState(() {
        isLoading = false;
      });

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff00b212),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content: Text("Berhasil Hapus Rute", textAlign: TextAlign.center)));

        getInit();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 3),
            content: Text(response, textAlign: TextAlign.center)));
      }
    }

    void ShowHideDetail(int index, bool isShow) {
      WorkInProgress wip =
          Provider.of<WorkInProgressProvider>(context, listen: false).work;

      Provider.of<WorkInProgressProvider>(context, listen: false)
          .ShowHideDetail(index, isShow, wip);
    }

    Color getColor(String status) {
      if (status == "Done") {
        return Color(0xffe0f6e2);
      } else if (status == "On The Way") {
        return Color(0xffffffd2);
      } else {
        return Color(0xffCFE7FF);
      }
    }

    void setCheckbox(int index, String name) {
      bool current = list_checkbox[index][name];

      if (current) {
        list_progress[index] = "-";
      } else if (!current) {
        list_progress[index] = name;
      }

      setState(() {
        list_checkbox[index][name] = !list_checkbox[index][name];
      });
    }

    bool checkDisabledCheckbox(int current, int limit) {
      if (current >= limit) {
        if (limit < current) {
          return true;
        }

        return false;
      } else {
        return true;
      }
    }

    Widget CustomCheckbox(String label, bool isChecked, bool isDisabled,
        onChanged(bool? checkBoxState)) {
      return Column(children: [
        Transform.scale(
            scale: 2,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Color(0xffE5F5E1);
                } else if (states.contains(MaterialState.disabled)) {
                  return Colors.black;
                }
                return Colors.orange;
              }),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(
                      width: 1, color: Color.fromARGB(255, 0, 0, 0))),
              activeColor: Colors.white,
              checkColor: Colors.black,
              value: isChecked,
              onChanged: isDisabled ? null : onChanged,
              // onChanged: (_) {},
            )),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600))
      ]);
    }

    Widget Item(Color color, String index, Task task, String id) {
      return GestureDetector(
        onTap: () {
          ShowHideDetail(int.parse(index) - 1, !task.is_show);
        },
        child: Column(
          children: [
            !task.is_show
                ? Container(
                    padding: padding,
                    decoration: BoxDecoration(
                        color: color,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 30,
                              child: Text(index,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700))),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(task.perusahaan,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Text(task.status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                    children: task.list_sj
                                        .map((item) => Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.no,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    SizedBox(height: 5),
                                                  ]),
                                            ))
                                        .toList()),
                              ],
                            ),
                          ),
                        ]))
                : Container(
                    padding: padding,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: color,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 30,
                              child: Text(index,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700))),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(task.perusahaan,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Text(task.status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                    children: task.list_sj
                                        .map((item) => Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.no,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    SizedBox(height: 5),
                                                    Column(
                                                        children: item.list_task
                                                            .map((item2) => Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(item2
                                                                        .item),
                                                                    Text(item2
                                                                        .weight)
                                                                  ],
                                                                ))
                                                            .toList()),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Total ${item.total_item} Item',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        Text(item.total_weight,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
                                                  ]),
                                            ))
                                        .toList()),
                                task.progress_eksternal == 4
                                    ? SizedBox()
                                    : !task.is_enable
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomCheckbox(
                                                      "Sampai",
                                                      list_checkbox[
                                                          int.parse(index) -
                                                              1]["sampai"],
                                                      checkDisabledCheckbox(
                                                          task
                                                              .progress_eksternal,
                                                          1),
                                                      (bool? checkboxState) {
                                                    setCheckbox(
                                                        int.parse(index) - 1,
                                                        "sampai");
                                                  }),
                                                  CustomCheckbox(
                                                      "Mulai",
                                                      list_checkbox[
                                                          int.parse(index) -
                                                              1]["mulai"],
                                                      checkDisabledCheckbox(
                                                          task
                                                              .progress_eksternal,
                                                          2),
                                                      (bool? checkboxState) {
                                                    setCheckbox(
                                                        int.parse(index) - 1,
                                                        "mulai");
                                                  }),
                                                  CustomCheckbox(
                                                      "Selesai",
                                                      list_checkbox[
                                                          int.parse(index) -
                                                              1]["selesai"],
                                                      checkDisabledCheckbox(
                                                          task
                                                              .progress_eksternal,
                                                          3),
                                                      (bool? checkboxState) {
                                                    setCheckbox(
                                                        int.parse(index) - 1,
                                                        "selesai");
                                                  }),
                                                  task.progress_eksternal < 3
                                                      ? Button(
                                                          width: 80,
                                                          title: "Hapus Rute",
                                                          bgColor:
                                                              Color(0xffff0000),
                                                          borderColor:
                                                              Color(0xffff0000),
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            handleHapusRute(
                                                                list_controller[
                                                                        int.parse(index) -
                                                                            1]
                                                                    .text,
                                                                id.toString(),
                                                                task.perusahaan,
                                                                task.no_urut
                                                                    .toString());
                                                          },
                                                          fontSize: 12,
                                                          height: 30,
                                                          isLoading: false)
                                                      : SizedBox()
                                                ],
                                              ),
                                              Input(
                                                  width: double.infinity,
                                                  label: "",
                                                  controller: list_controller[
                                                      int.parse(index) - 1]),
                                              SizedBox(height: 10),
                                              Button(
                                                  title: "SIMPAN",
                                                  bgColor: Color(0xff5493CA),
                                                  borderColor:
                                                      Color(0xff5493CA),
                                                  textColor: Colors.white,
                                                  isDisabled: list_progress[
                                                              int.parse(index) -
                                                                  1] ==
                                                          "-"
                                                      ? true
                                                      : false,
                                                  onPressed: () {
                                                    handleUpdateProgress(
                                                        list_progress[
                                                            int.parse(index) -
                                                                1],
                                                        list_controller[
                                                                int.parse(
                                                                        index) -
                                                                    1]
                                                            .text,
                                                        id.toString(),
                                                        task.perusahaan,
                                                        int.parse(index) - 1,
                                                        task.no_urut);
                                                  },
                                                  fontSize: 15,
                                                  height: 40,
                                                  width: double.infinity,
                                                  isLoading: false),
                                            ],
                                          )
                              ],
                            ),
                          ),
                        ])),
          ],
        ),
      );
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
            title: const Text(
              "Work in Progress",
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
                    padding: EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: decoration,
                                padding: padding,
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Saldo",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(workProvider.work.total_saldo,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                    SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Uang Saku",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              workProvider
                                                  .work.total_pocket_money,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                        ]),
                                    SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pengeluaran",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xffff0000),
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              workProvider
                                                  .work.total_pengeluaran,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xffff0000),
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                    SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                              title: "Input",
                                              width: 100,
                                              height: 35,
                                              fontSize: 15,
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    "/input-pengeluaran",
                                                    arguments: {
                                                      "idWip": id,
                                                      "type": "input",
                                                      "from": "/wip"
                                                    }).then((_) => {getInit()});
                                              },
                                              bgColor: Color(0xffff0000),
                                              borderColor: Color(0xffff0000),
                                              textColor: Colors.white,
                                              isLoading: false),
                                          Button(
                                              title: "Detail",
                                              width: 100,
                                              height: 35,
                                              fontSize: 15,
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                        "/detail-pengeluaran",
                                                        arguments: id)
                                                    .then((_) => {getInit()});
                                              },
                                              bgColor: Color(0xff5493CA),
                                              borderColor: Color(0xff5493CA),
                                              textColor: Colors.white,
                                              isLoading: false),
                                        ])
                                  ],
                                )),
                            SizedBox(height: 20),
                            Column(
                              children: workProvider.work.list_task
                                  .asMap()
                                  .entries
                                  .map((item) => Item(
                                      getColor(item.value.status),
                                      (item.key + 1).toString(),
                                      item.value,
                                      workProvider.work.id))
                                  .toList(),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'TOTAL : ${workProvider.work.total_item} item',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(workProvider.work.tonase_kirim,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                            SizedBox(height: 40),
                          ]),
                    ))));
  }
}
