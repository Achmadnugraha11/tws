import 'package:flutter/material.dart';
import 'package:viginesia_app/pages/Login.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class mainScreen extends StatefulWidget {
  const mainScreen({Key? key, required String iduser, required String nama}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, 
                children: 
                [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Halo",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        child: Icon(Icons.logout),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (BuildContext context) => new Login(),
                              ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FormBuilderTextField(
                    controller: isiController,
                    name: "isi_motivasi",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        print("Berhasil");
                      },
                      child: Text("Kirim"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(child: Icon(Icons.refresh), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
