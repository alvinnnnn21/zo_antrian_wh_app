// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_element, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/models/area_model.dart';
import 'package:sutindo_supir_app/providers/area_provider.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final storage = GetStorage();
  bool isLoading = true;
  dynamic selectedValue = "";

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      getInit();
    });
    super.initState();
  }

  getInit() async {
    dynamic response =
        await Provider.of<AreaProvider>(context, listen: false).GetArea();

    final area = storage.read("area");

    List<Area> list_area =
        Provider.of<AreaProvider>(context, listen: false).area;

    bool isFound = false;

    if (list_area.length > 0) {
      isFound = list_area.indexWhere((item) => item.areaID == area) > 0
          ? true
          : false;
    }

    if (isFound) {
      setState(() => {selectedValue = area});
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

  void saveArea() {
    final storage = GetStorage();
    storage.write("area", selectedValue.toString());
    Navigator.popAndPushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    AreaProvider areaProvider = Provider.of<AreaProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, "/login");
        return true;
      },
      child: Scaffold(
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
                  child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Setting Area",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                        SizedBox(height: 100),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Color(0xff2a78be), width: 2)),
                          width: 250,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                iconEnabledColor: Color(0xff2a78be),
                                hint: Text("Pilih Area"),
                                value: selectedValue,
                                onChanged: (dynamic newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: areaProvider.area
                                    .map((item) => DropdownMenuItem(
                                        value: item.areaID,
                                        child: Text(item.areaName,
                                            style: TextStyle(
                                                color: Color(0xff2a78be)))))
                                    .toList()),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          child: Button(
                              isDisabled: selectedValue == "",
                              isLoading: isLoading,
                              title: "SIMPAN",
                              bgColor: Color(0xff2a78be),
                              borderColor: Color(0xff2a78be),
                              onPressed: saveArea,
                              textColor: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Button(
                              isLoading: isLoading,
                              title: "KEMBALI",
                              bgColor: Colors.red,
                              borderColor: Colors.red,
                              onPressed: () {
                                Navigator.popAndPushNamed(context, "/login");
                              },
                              textColor: Colors.white),
                        )
                      ]),
                ))),
    );
  }
}
