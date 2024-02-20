import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String?id,username,email,Address_controller;
  UserModel({this.email,this.id,this.username,this.Address_controller});
  factory UserModel.fromMap(DocumentSnapshot map){
    return UserModel(
    email: map["email"],
    username: map["username"],
    Address_controller: map["Address_controller"],
    id: map.id
    );
  }
  Map<String,dynamic>toMap(){
    return{
    //  "id":id,
      "email":email,
      "username":username,
      "Address_controller":Address_controller,
    };
  }
}