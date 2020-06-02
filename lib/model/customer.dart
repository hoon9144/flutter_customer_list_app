//모델 클래스
class Customer{

  final int seq;
  final String name;
  final String age;

  Customer({this.seq , this.name , this.age});

  factory Customer.fromJson(Map<String,dynamic> json){
    return Customer(seq: json['seq'] , name:  json['name'],age: json['age']);
  }

}