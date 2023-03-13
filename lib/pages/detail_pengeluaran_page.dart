// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/providers/pengeluaran_provider.dart';
import 'package:sutindo_supir_app/theme.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';

class DetailPengeluaranPage extends StatefulWidget {
  const DetailPengeluaranPage({Key? key}) : super(key: key);

  @override
  State<DetailPengeluaranPage> createState() => _DetailPengeluaranPageState();
}

class _DetailPengeluaranPageState extends State<DetailPengeluaranPage> {
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
    int id = ModalRoute.of(context)!.settings.arguments as int;

    final String token = storage.read("token");

    dynamic response =
        await Provider.of<PengeluaranProvider>(context, listen: false)
            .GetDetailPengeluaran(token: token, id: id.toString());

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
    PengeluaranProvider pengeluaranProvider =
        Provider.of<PengeluaranProvider>(context);
    int id = ModalRoute.of(context)!.settings.arguments as int;

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
              "Detail Uang Saku",
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
                                  Text(
                                      pengeluaranProvider
                                          .pengeluaran.total_saldo,
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
                                          color: Color(0xff33995E))),
                                  Text(
                                      pengeluaranProvider
                                          .pengeluaran.total_uang_saku,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff33995E)))
                                ]),
                            SizedBox(height: 10),
                            Column(
                                children: pengeluaranProvider
                                    .pengeluaran.list_pocket_money
                                    .map((item) => Container(
                                          height: 35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          iconSize: 30,
                                                          onPressed:
                                                              item.status == "2"
                                                                  ? () {
                                                                      Navigator.pushNamed(
                                                                          context,
                                                                          "/input-pengeluaran",
                                                                          arguments: {
                                                                            "idWip":
                                                                                id,
                                                                            "type":
                                                                                "edit",
                                                                            "from":
                                                                                "/detail-pengeluaran",
                                                                            "idPengeluaran":
                                                                                item.id,
                                                                            "nominal":
                                                                                item.ammount,
                                                                            "purpose":
                                                                                item.purpose,
                                                                            "total_uang_saku":
                                                                                pengeluaranProvider.pengeluaran.total_saldo
                                                                          }).then(
                                                                          (_) =>
                                                                              {
                                                                                getInit()
                                                                              });
                                                                    }
                                                                  : null,
                                                          icon: Icon(Icons
                                                              .edit_note_sharp)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 4),
                                                        child: Expanded(
                                                          child: Text(
                                                              item.purpose,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffff0000))),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(item.ammount,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffff0000))))
                                            ],
                                          ),
                                        ))
                                    .toList()),
                            SizedBox(height: 10),
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
                                        Navigator.pushNamed(
                                            context, "/input-pengeluaran",
                                            arguments: {
                                              "idWip": id,
                                              "type": "input",
                                              "from": "/detail-pengeluaran",
                                              "total_uang_saku":
                                                  pengeluaranProvider
                                                      .pengeluaran.total_saldo
                                            }).then((_) => {getInit()});
                                      },
                                      bgColor: Color(0xffff0000),
                                      borderColor: Color(0xffff0000),
                                      textColor: Colors.white,
                                      isLoading: false),
                                ])
                          ],
                        )),
                  ],
                )),
              )));
  }
}
