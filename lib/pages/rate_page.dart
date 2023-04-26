// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/providers/rate_provider.dart';
import 'package:sutindo_supir_app/theme.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/info_widget.dart';
import 'package:sutindo_supir_app/widgets/label_widget.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final storage = GetStorage();
  bool isLoading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      getInit();
    });
    super.initState();
  }

  getInit() async {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String token = storage.read("token");
    dynamic response = await Provider.of<RateProvider>(context, listen: false)
        .GetRate(token: token, id: data["id"]);

    setState(() {
      isLoading = false;
    });

    if (response != true) {
      if (response == "401") {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 2),
            content: Text("Token expired, silahkan login kembali",
                textAlign: TextAlign.center)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffff0000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 2),
            content: Text(response, textAlign: TextAlign.center)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    RateProvider rateProvider = Provider.of<RateProvider>(context);
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    handlePocketMoneySign(id) async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");
      dynamic response = await rateProvider.ActionUangSaku(
          token: token, type: "sign", id: int.parse(id));

      setState(() {
        isLoading = false;
      });
      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff00b212),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 2),
            content: Text("Berhasil Sign Rate", textAlign: TextAlign.center)));

        Navigator.pop(context);

        // Navigator.popAndPushNamed(context, "/home");
      } else {
        if (response == "401") {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 2),
              content: Text("Token expired, silahkan login kembali",
                  textAlign: TextAlign.center)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 2),
              content: Text(response, textAlign: TextAlign.center)));
        }
      }
    }

    handlePocketMoneyReject(id) async {
      setState(() {
        isLoading = true;
      });

      final token = storage.read("token");

      dynamic response = await rateProvider.ActionUangSaku(
          token: token, type: "reject", id: int.parse(id));

      setState(() {
        isLoading = false;
      });

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff00b212),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            duration: Duration(seconds: 2),
            content:
                Text("Berhasil Reject Rate", textAlign: TextAlign.center)));

        Navigator.pop(context);
      } else {
        if (response == "401") {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 2),
              content: Text("Token expired, silahkan login kembali",
                  textAlign: TextAlign.center)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xffff0000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              duration: Duration(seconds: 2),
              content: Text(response, textAlign: TextAlign.center)));
        }
      }
    }

    showAlertDialog(BuildContext context, id) {
      AlertDialog alert = AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Apakah kamu yakin untuk melakukan reject ?"),
        actions: [
          Button(
              title: "Ya",
              width: 100,
              height: 35,
              fontSize: 15,
              onPressed: () {
                Navigator.pop(context);
                handlePocketMoneyReject(id);
              },
              bgColor: Color(0xff00b212),
              borderColor: Color(0xff00b212),
              textColor: Colors.white,
              isLoading: false),
          Button(
              title: "Tidak",
              width: 100,
              height: 35,
              fontSize: 15,
              onPressed: () {
                Navigator.pop(context);
              },
              bgColor: Color(0xffff0000),
              borderColor: Color(0xffff0000),
              textColor: Colors.white,
              isLoading: false),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    Widget Item(int index, Task task, String id) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(width: 1)),
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: index > 99 ? 30 : 20,
                child: Text(index.toString(),
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(task.perusahaan,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                      children: task.list_sj
                          .map((item) => Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.no,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(height: 5),
                                      Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: {
                                            0: FlexColumnWidth(),
                                            1: IntrinsicColumnWidth()
                                          },
                                          children: item.list_task
                                              .map(
                                                  (item2) => TableRow(
                                                          children: [
                                                            TableCell(
                                                              child: Text(
                                                                item2.item,
                                                              ),
                                                            ),
                                                            TableCell(
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5),
                                                                child: Row(
                                                                    children: item2
                                                                        .list_lokasi
                                                                        .map((item3) =>
                                                                            Container(
                                                                              margin: EdgeInsets.symmetric(horizontal: 2),
                                                                              child: Text(item3.lokasi, style: TextStyle(color: Color(0xff338bf6))),
                                                                            ))
                                                                        .toList()),
                                                              ),
                                                            ),
                                                          ]))
                                              .toList())
                                    ]),
                              ))
                          .toList())
                ],
              ),
            ),
          ]));
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
              data["rate"],
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
                child: SingleChildScrollView(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Info(onPressed: () {}, isCard: true, info: {
                                "id": 0,
                                "sopir": rateProvider.rate.sopir,
                                "armada": rateProvider.rate.armada,
                                "kernet": rateProvider.rate.kernet,
                                "nopol": rateProvider.rate.nopol,
                                "rate": rateProvider.rate.rate,
                                "customer": rateProvider.rate.list_task.length
                                    .toString(),
                                "kapasitas": rateProvider.rate.kapasitas,
                                "tonase": rateProvider.rate.tonase_kirim,
                              }),
                              Column(
                                  children: rateProvider.rate.list_task
                                      .asMap()
                                      .entries
                                      .map((item) =>
                                          Item(item.key + 1, item.value, "0"))
                                      .toList()),
                              SizedBox(height: 10),
                              Container(
                                  padding: padding,
                                  decoration: decoration,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tonase per area (kg)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        LabelList(
                                            type: "spaceBetween",
                                            label: rateProvider.rate.list_tonase
                                                .map((item) => item.keterangan)
                                                .toList(),
                                            value: rateProvider.rate.list_tonase
                                                .map((item) => Text(
                                                    item.jumlah.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)))
                                                .toList()),
                                      ])),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                      padding: padding,
                                      decoration: decoration,
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Uang Saku",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    ((rateProvider
                                                                .rate
                                                                .list_pocket_money
                                                                .isNotEmpty)
                                                            ? rateProvider
                                                                .rate
                                                                .list_pocket_money[
                                                                    0]
                                                                .ammount
                                                            : 0)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                          SizedBox(height: 20),
                                          data["isEnabled"]
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                      Button(
                                                          title: "Sign",
                                                          width: 100,
                                                          height: 35,
                                                          fontSize: 15,
                                                          onPressed: () {
                                                            handlePocketMoneySign(
                                                                rateProvider
                                                                    .rate.id);
                                                          },
                                                          bgColor:
                                                              Color(0xff00b212),
                                                          borderColor:
                                                              Color(0xff00b212),
                                                          textColor:
                                                              Colors.white,
                                                          isLoading: false),
                                                      Button(
                                                          title: "Reject",
                                                          width: 100,
                                                          height: 35,
                                                          fontSize: 15,
                                                          // onPressed:
                                                          //     handlePocketMoneyReject,
                                                          onPressed: () {
                                                            showAlertDialog(
                                                                context,
                                                                rateProvider
                                                                    .rate.id);
                                                          },
                                                          bgColor:
                                                              Color(0xffff0000),
                                                          borderColor:
                                                              Color(0xffff0000),
                                                          textColor:
                                                              Colors.white,
                                                          isLoading: false),
                                                    ])
                                              : SizedBox(height: 0)
                                        ],
                                      ))
                                ],
                              )
                              // Column(
                              //     children: rateProvider.rate.list_pocket_money
                              //         .map((item) => )
                              //         .toList())
                            ])))));
  }
}
