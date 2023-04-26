// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sutindo_supir_app/providers/auth_provider.dart';
import 'package:sutindo_supir_app/widgets/button_widget.dart';
import 'package:sutindo_supir_app/widgets/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    void handleLogin() async {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        setState(() {
          isError = true;
          errorMessage = "Username dan Password wajib diisi";
        });

        return;
      }

      final storage = GetStorage();
      final area = storage.read("area");

      if (area == null) {
        setState(() {
          isError = true;
          errorMessage = "Silahkan pilih area terlebih dahulu";
        });

        return;
      }

      setState(() {
        isLoading = true;
        isError = false;
        errorMessage = "";
      });

      dynamic response = await authProvider.Login(
          username: usernameController.text, password: passwordController.text);

      setState(() {
        isLoading = false;
      });

      if (response == true) {
        Navigator.popAndPushNamed(context, "/home");
      } else {
        setState(() {
          isError = true;
          errorMessage = response;
        });
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Column(
          children: [
            Container(
                height: 50,
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, "/config");
                    },
                    icon: Icon(Icons.settings))),
            Flexible(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/ic_logo_sutindo.png")))),
                      isError
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Color(0xffFEB5B5),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: Text(errorMessage,
                                    style: TextStyle(
                                        color: Color(0xffF25B60),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ))
                          : const SizedBox(height: 100),
                      Input(label: "Username", controller: usernameController),
                      const SizedBox(height: 15),
                      Input(
                          label: "Password",
                          controller: passwordController,
                          obscureText: true),
                      const SizedBox(height: 20),
                      Container(
                        child: Button(
                            isLoading: isLoading,
                            title: "LOGIN",
                            bgColor: Color(0xff2a78be),
                            borderColor: Color(0xff2a78be),
                            onPressed: handleLogin,
                            textColor: Colors.white),
                      )
                    ]),
              ),
            ),
          ],
        ))));
  }
}
