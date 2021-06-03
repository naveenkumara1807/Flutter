//import 'package:apiui/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login/login/login.dart';

void main() {
  runApp(Screenwelcome(
    name: '',
  ));
}

class Screenwelcome extends StatefulWidget {
  String name;

  Screenwelcome({@required this.name});

  @override
  _ScreenwelcomeState createState() => _ScreenwelcomeState(name);
}

class _ScreenwelcomeState extends State<Screenwelcome> {
  String name;
  _ScreenwelcomeState(this.name);
  bool isLoading = false;

  List users = [];

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  Future fetchUser() async {
    setState(() {
      isLoading = true;
    });
    String first = "http://jsonplaceholder.typicode.com/users/?id=";
    var url = first + name;
    print(url);
    http.Response response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body.toString());
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Users"),
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: Icon(Icons.supervised_user_circle_sharp),
            tooltip: 'users',
            onPressed: () {},
          )),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var fname = item['name'];
    var usrname = item['username'];
    var email = item['email'];
    var address = item['address']['street'] +
        item['address']['suite'] +
        item['address']['city'] +
        item['address']['zipcode'];
    var ph = item['phone'];
    var webs = item['website'];
    var comp = item['company']['name'] +
        item['company']['catchPhrase'] +
        item['company']['bs'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(60 / 2),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373__340.jpg"))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        fname,
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      usrname.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      email.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      address.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      ph.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      webs.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      comp.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child:
                        Text('posts', style: TextStyle(color: Colors.black87)),
                    onPressed: () {
                      //if(formKey.currentState.validate()){
                      //print ('validated');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login(value: name)));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          /*onTap: (){
            Navigator.push(context, MaterialPageRoute(
             builder: (context)=>Third(value:name)
           )
           );
          },
          */
        ),
      ),
    );
  }
}
