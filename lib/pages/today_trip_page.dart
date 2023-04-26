// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/providers/today_trip_provider.dart';
import 'package:sutindo_supir_app/theme.dart';
import 'package:sutindo_supir_app/widgets/label_widget.dart';

class TodayTripPage extends StatefulWidget {
  const TodayTripPage({Key? key}) : super(key: key);

  @override
  State<TodayTripPage> createState() => _TodayTripPageState();
}

class _TodayTripPageState extends State<TodayTripPage> {
  final storage = GetStorage();
  bool isLoading = true;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    final String token = storage.read("token");
    dynamic response =
        await Provider.of<TodayTripProvider>(context, listen: false)
            .GetTodayTrip(token: token);

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

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TodayTripProvider todayTripProvider =
        Provider.of<TodayTripProvider>(context);

    return Scaffold(
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
              "Today's Trips",
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
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            // ignore: prefer_const_literals_to_create_immutables
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 10, right: 10, bottom: 10),
                              decoration: decoration,
                              child: LabelList(label: [
                                "Nama",
                                "Jumlah Rate",
                                "Tuntas Kirim",
                                "Tonase Kirim"
                              ], value: [
                                Text(todayTripProvider.today.name.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                    todayTripProvider.today.jumlah_rate
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                    todayTripProvider.today.tuntas_kirim
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                    todayTripProvider.today.tonase_kirim
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ]),
                            ),
                            SizedBox(height: 10),
                            Container(
                                width: double.infinity,
                                padding: padding,
                                decoration: decoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("JKA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Column(
                                        children: todayTripProvider.today.jka
                                            .asMap()
                                            .entries
                                            .map((item) => Container(
                                                  margin:
                                                      EdgeInsets.only(top: 12),
                                                  child: Text(
                                                      '${item.key + 1}. ${item.value}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ))
                                            .toList())
                                  ],
                                )),
                            const SizedBox(height: 10),
                            Container(
                                width: double.infinity,
                                padding: padding,
                                decoration: decoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("JPA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Column(
                                      children: todayTripProvider.today.jpa
                                          .asMap()
                                          .entries
                                          .map((item) => Container(
                                                margin:
                                                    EdgeInsets.only(top: 12),
                                                child: Text(
                                                    '${item.key + 1}. ${item.value}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ))
                                          .toList(),
                                    )
                                  ],
                                )),
                            const SizedBox(height: 10),
                            Container(
                                width: double.infinity,
                                padding: padding,
                                decoration: decoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Pengeluaran",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: todayTripProvider
                                          .today.list_pocket_money
                                          .asMap()
                                          .entries
                                          .map((item) => Container(
                                                margin:
                                                    EdgeInsets.only(top: 12),
                                                child: Text(
                                                    '${item.key + 1}. ${item.value.ammount}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ))
                                          .toList(),
                                    )
                                  ],
                                )),
                          ],
                        )))));
  }
}
