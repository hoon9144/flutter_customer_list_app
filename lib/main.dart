import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercrud0602/insert.dart';
import 'package:fluttercrud0602/model/customer.dart';
import 'package:fluttercrud0602/update.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: MyApp()));


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //빈리스트
  List<dynamic> _list = [];
  //유저 버튼누르면 유저 정보 가져옴
  void getUser() async{
    var res = await http.get('http://192.168.0.8:3000/user');
    List<Customer> parseUser = jsonDecode(res.body)
      .map<Customer>((json) => Customer.fromJson(json))
      .toList();
    setState(() {
      _list.clear();
      _list.addAll(parseUser);
    });
  }

//  void deleteUser() async{
//    var res = await http.delete(url)
//
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.account_circle), onPressed: getUser)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Insert()));
      }),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context , index) {
        return ListTile(
          leading: Text('seq : ${_list[index].seq}'),
          title: Text('name : ${_list[index].name}'),
          subtitle: Text('age : ${_list[index].age}'),
          trailing: Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.settings), onPressed: (){
                print('touch seq is ${_list[index].seq}');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Update(seq: _list[index].seq)));
              }),
            ],
          ),
        );
      }),
    );
  }
}
