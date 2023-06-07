import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:viginesia_app/pages/Register.dart';
import 'package:viginesia_app/pages/mainScreen.dart';
import 'package:viginesia_app/color.dart';
import 'package:viginesia_app/constant/const.dart';
import 'package:another_flushbar/flushbar.dart';
import 'dart:convert';
import 'package:viginesia_app/models/Login_model.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String nama;
  late String iduser;

  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

// Future <LoginModels>
  Future postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl = url;

    Map<String, dynamic> data = {"email": email, "password": password};
    try {
      final response = await dio.post("$baseurl/vigenesia/api/login",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));
      print("Respon -> ${response.data}+${response.statusCode}");
      if (response.statusCode == 200) {
        final loginModel = LoginModels.fromJson(response.data);
        return loginModel;
      }
    } catch (e) {
      print("Failed to load $e");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Center(
                  child: Form(
                      child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(children: [
                      FormBuilderTextField(
                        name: "email",
                        controller: emailController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "Email"),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        obscureText: true, // teks menjadi bintang
                        name: "Password",
                        controller: passwordController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                      ),
                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Belum punya akun?',
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                            text: 'Daftar',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Register() //
                                      ),
                                );
                              },
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 41, 16, 149)),
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            await postLogin(
                              emailController.text,
                              passwordController.text,
                            ).then((value) => {
                                  if (value != null)
                                    {
                                      setState(() {
                                        nama = value.data.nama;
                                        iduser = value.data.iduser;
                                        print("ini data id ---> ${iduser}");
                                        Navigator.push(context,
                                         MaterialPageRoute(builder: (context) => 
                                         mainScreen(
                                          iduser: iduser,
                                          nama: nama
                                         )));
                                      })
                                    }
                                    else if (value == null) {
                                      Flushbar(
                                      message: "Cek Email atau password",
                                      duration: Duration(seconds: 4),
                                      backgroundColor: Colors.yellow,
                                      flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context)
                                    }
                                });
                          },
                          child: Text("Masuk",
                              style: TextStyle(fontSize: 15, fontWeight: bold)),
                        ),
                      ),
                    ]),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
