import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('API'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder:(context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Text('Loading');
                    }else{
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context,index){
                            return Card(
                              child: Column(
                                children: [
                                  ReUsableRow(title: 'name', value: data[index]['name'].toString()),
                                  ReUsableRow(title: 'username', value: data[index]['username'].toString()),
                                  ReUsableRow(title: 'address', value: data[index]['address']['street'].toString(),),
                                ],
                              ),
                            );
                          });
                    }

                  }))
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
