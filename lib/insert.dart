import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Insert extends StatefulWidget {
  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {

  final TextEditingController nameTf = TextEditingController();
  final TextEditingController ageTf = TextEditingController();
  
  void insertUser() async{
    try {
      var res =  await http.post('http://192.168.0.8:3000/user/join',
        body: jsonEncode(
          {
            'name':nameTf.text,
            'age':ageTf.text
          },
        ),
        headers: {'Content-Type': "application/json"},
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body.toString()}');
     // Scaffold.of(context).showSnackBar(SnackBar(content: Text('성공')));
      setState(() {
        nameTf.text = '';
        ageTf.text = '';
      });
    }catch(e){
      print('error => : ${e}');
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('insert'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextField(
              controller: nameTf,
              decoration: InputDecoration(
                hintText: 'name',
                  border: OutlineInputBorder()
              )
          ),
          SizedBox(height: 20),
          TextField(
              controller: ageTf,
              decoration: InputDecoration(
                hintText: 'age',
                  border: OutlineInputBorder()
              )
          ),
          RaisedButton(
              child: Text('입력'),
              onPressed: (){
            print('이름 : ${nameTf.text} 나이 : ${ageTf.text}');
            insertUser();
          })
        ],
      ),
    );
  }
}
