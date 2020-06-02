import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercrud0602/model/customer.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  //메인 페이지에서 수정버튼 누른 seq 화면이동시에 데이터 전달받음.
  int seq;
  Update({this.seq});

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

  //수정할 텍스트 필드값!
  TextEditingController nameTf = TextEditingController();
  TextEditingController ageTf = TextEditingController();

  //텍스트필드 초기값
  String name = '';
  String age = '';

  //빈리스트
  List user = [];

  void getUserId() async {

    var res = await http.get('http://192.168.0.8:3000/user/${widget.seq}');
    List<Customer> parseUser = jsonDecode(res.body)
      .map<Customer>((json) => Customer.fromJson(json))
      .toList();

    setState(() {
      user.clear();
      user.addAll(parseUser);
      name = user[0].name;
      age = user[0].age;
    });

  }
  
  //업데이트
  void updateUser() async {

    try{
      var res = await http.put('http://192.168.0.8:3000/user/${widget.seq}' ,
          body: jsonEncode(
              {
                'name':nameTf.text,
                'age':ageTf.text
              }
          ),headers:  {'Content-Type': "application/json"}
      );
      print('status => ${res.statusCode}');
      print('body => ${res.body}');
      setState(() {
        Navigator.pop(context);
      });
    }catch(e){
      print('error => : ${e}');
    }
  }

  //삭제
  void deleteUser() async {
    try{
      var res = await http.delete('http://192.168.0.8:3000/delete/${widget.seq}');
      print('status => ${res.statusCode}');
      print('body => ${res.body}');
      setState(() {
        Navigator.pop(context);
      });
    }catch(e){
      print('error => : ${e}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  
  

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextField(
            controller: nameTf,
            decoration: InputDecoration(
              hintText: '${name}',
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: ageTf,
            decoration: InputDecoration(
                hintText: '${age}',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
              child: Text('수정'),
              onPressed: (){
                updateUser();
          }),
          SizedBox(height: 20,),
          RaisedButton(
              child: Text('삭제'),
              onPressed: (){
                deleteUser();
              })
        ],
      ),
    );
  }
}
