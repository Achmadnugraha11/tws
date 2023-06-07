import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart' show Flushbar, FlushbarPosition;
// import 'package:viginesia_app/pages/Login.dart';
import 'package:viginesia_app/constant/const.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String baseurl = url;
  Future postRegister(
      String nama, String email, String profesi, String password) async {
    var dio = Dio();
    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };
    try {
      var baseurl2 = baseurl;
      final response = await dio.post("$baseurl2/viginesia/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));
      print("Respon -> ${response.data}+ ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
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
                  "Daftar",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Center(
                  child: Form(
                      child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(children: [
                      FormBuilderTextField(
                        name: "name",
                        controller: nameController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "nama"),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "profesi",
                        controller: profesiController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "profesi"),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "email",
                        controller: emailController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "email"),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        obscureText: true, // teks menjadi bintang
                        name: "password",
                        controller: passwordController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(),
                            labelText: "password"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            await postRegister(
                                    nameController.text,
                                    profesiController.text,
                                    emailController.text,
                                    passwordController.text)
                                    .then((value) => {
                                      if (value != null)
                                        {
                                          setState(() {
                                            Navigator.pop(context);
                                            Flushbar(
                                              message: "Registrasi Berhasil",
                                              duration: Duration(seconds: 3),
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                            ).show(context);
                                          })
                                        }
                                      else if (value == null)
                                        {
                                          Flushbar(
                                            message:
                                                "Check Your Field Before Register",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.redAccent,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context)
                                        }
                                    });
                          },
                          child: Text("Daftar"),
                        ),
                      )
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
