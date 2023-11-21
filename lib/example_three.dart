import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }else{
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReUsableRow(title: 'name', value: snapshot.data![index].name.toString()),
                                  ReUsableRow(title: 'username', value: snapshot.data![index].username.toString()),
                                  ReUsableRow(title: 'email', value: snapshot.data![index].email.toString()),
                                  ReUsableRow(title: 'Address', value: snapshot.data![index].address!.geo!.lat.toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
