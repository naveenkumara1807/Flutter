import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:login/login/splash.dart';

void main() {
  runApp(login());
}

class login extends StatefulWidget {
  String value;

  login({@required this.value});

  @override
  _login createState() => _login(value);
}

class _login extends State<login> {
  String value;
  _login(this.value);
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  Future fetchUser() async {
    setState(() {
      isLoading = true;
    });
    String first = "http://jsonplaceholder.typicode.com/posts/?userId=";
    var url = first + value;
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
          title: Text("POSTS"),
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: Icon(Icons.post_add_sharp),
            tooltip: 'post',
            onPressed: () {},
          )),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.amberAccent),
      ));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var body = item['body'];
    return Card(
      elevation: 50,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black,
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
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        body,
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
