import 'package:flutter/material.dart';
import 'package:login/splash/splash.dart';
//import 'splash.dart';
import 'package:login/main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Loginpage();
  }
}

class Loginpage extends State<MyApp> {
  String _val;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final idcontroller = new TextEditingController();

  void _onchange(String value) {
    setState(() {
      _val = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            /*decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373__340.jpg"),
                    fit: BoxFit.fill)),*/
            child: Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.blue,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 80),
            TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  hintText: "Enter id",
                ),
                keyboardType: TextInputType.number,
                controller: idcontroller,
                onChanged: _onchange,
                validator: (value) {
                  if (value.isEmpty) {
                    return "valid id required";
                  } else {
                    return null;
                  }
                }),
            SizedBox(
              width: 15,
              height: 15,
            ),
            RaisedButton(
              child: Text('Submit', style: TextStyle(color: Colors.black87)),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  print('validated');
                  String val = idcontroller.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Screenwelcome(name: val)));
                }
              },
              /*shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              color: Colors.white10,*/
            ),
          ],
        ),
      ),
    )));
  }
}
