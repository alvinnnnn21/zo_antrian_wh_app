// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, sized_box_for_whitespace, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/providers/home_provider.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/info_widget.dart';
import 'package:sutindo_supir_app/widgets/text_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = GetStorage();
  bool isLoading = true;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    final String token = storage.read("token");

    setState(() {
      isLoading = true;
    });

    dynamic response = await Provider.of<HomeProvider>(context, listen: false)
        .GetHome(token: token);

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await getInit();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    void onLogout() {
      storage.remove("token");
      storage.remove("name");
      storage.remove("id");

      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }

    bool checkEnabled(bool isNullWip, int index) {
      if (isNullWip) {
        if (index == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Color(0xff5493CA),
            leading: Center(
                child: Text('User ${storage.read("name")}',
                    style: TextStyle(fontSize: 15))),
            leadingWidth: double.infinity,
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.only(right: 10),
                child: Button(
                    title: "Logout",
                    onPressed: onLogout,
                    isLoading: false,
                    textColor: Colors.white,
                    fontSize: 14,
                    height: 10,
                    borderColor: Color(0xffF05C60),
                    bgColor: Color(0xffF05C60),
                    width: 70),
              )
            ]),
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
            : SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                enablePullDown: true,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                          child: Column(children: [
                        Image.asset("assets/icons/ic_logo_sutindo.png",
                            width: 240, height: 240),
                        SizedBox(height: 80),
                        Container(
                            width: double.infinity,
                            // height: 200,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Text("Work in Progress",
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(height: 20),
                                !homeProvider.home.wip["isNull"]
                                    ? Info(
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/wip",
                                                  arguments: homeProvider
                                                      .home.wip["id"])
                                              .then((_) => {getInit()});
                                        },
                                        isCard: false,
                                        info: {
                                            "id": homeProvider.home.wip["id"] ??
                                                "",
                                            "sopir": homeProvider
                                                    .home.wip["sopir"] ??
                                                "",
                                            "armada": homeProvider
                                                    .home.wip["armada"] ??
                                                "",
                                            "kernet": homeProvider
                                                    .home.wip["kernet"] ??
                                                "",
                                            "nopol": homeProvider
                                                    .home.wip["nopol"] ??
                                                "",
                                            "rate":
                                                homeProvider.home.wip["rate"] ??
                                                    "",
                                            "customer": homeProvider
                                                    .home.wip["customer"] ??
                                                "",
                                            "kapasitas": homeProvider
                                                    .home.wip["kapasitas"] ??
                                                "",
                                            "tonase": homeProvider
                                                    .home.wip["tonase"] ??
                                                "",
                                          })
                                    : Align(
                                        heightFactor: 4,
                                        alignment: Alignment.center,
                                        child: Text("No Data",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontStyle: FontStyle.italic)))
                              ],
                            )),
                        SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                child: SingleChildScrollView(
                                  child: Container(
                                      width: 100,
                                      child: Column(
                                          children: homeProvider.home.list_menu
                                              .asMap()
                                              .entries
                                              .map((item) => Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Button(
                                                        title: item.value.label,
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context, "/rate",
                                                              arguments: {
                                                                "id": item
                                                                    .value.id,
                                                                "rate": item
                                                                    .value
                                                                    .label,
                                                                "isNull":
                                                                    homeProvider
                                                                            .home
                                                                            .wip[
                                                                        "isNull"],
                                                                "isEnabled": checkEnabled(
                                                                    homeProvider
                                                                            .home
                                                                            .wip[
                                                                        "isNull"],
                                                                    item.key)
                                                              }).then((_) =>
                                                              {getInit()});
                                                        },
                                                        isLoading: false,
                                                        bgColor: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        width: 100),
                                                  ))
                                              .toList())),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/today-trip");
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Center(
                                          child: Column(children: [
                                        Text("My Trip's",
                                            style: TextStyle(fontSize: 20)),
                                        SizedBox(height: 20),
                                        Table(
                                          children: [
                                            TableRow(children: [
                                              TableCell(
                                                  child:
                                                      TextItem(label: "Nama")),
                                              TableCell(
                                                  child: TextItem(
                                                      label: homeProvider.home
                                                              .today["nama"] ??
                                                          "")),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                  child: TextItem(
                                                      label: "Jumlah Rate")),
                                              TableCell(
                                                  child: TextItem(
                                                      label: homeProvider
                                                                  .home.today[
                                                              "jumlah_rate"] ??
                                                          "")),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                  child: TextItem(
                                                      label: "Tuntas Kirim")),
                                              TableCell(
                                                  child: TextItem(
                                                      label: homeProvider
                                                                  .home.today[
                                                              "tuntas_kirim"] ??
                                                          "")),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                  child: TextItem(
                                                      label: "Tonase Kirim")),
                                              TableCell(
                                                  child: TextItem(
                                                      label: homeProvider
                                                                  .home.today[
                                                              "tonase_kirim"] ??
                                                          "")),
                                            ]),
                                          ],
                                        )
                                      ]))),
                                ),
                              )
                            ])
                      ])),
                    ),
                  ),
                ),
              ));
  }
}
