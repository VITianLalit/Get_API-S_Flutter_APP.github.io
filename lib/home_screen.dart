import 'dart:convert';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'Models/posts_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }return postList;
    }else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('API Course')),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Text('Loading');
                  }else{
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title:\n'+snapshot.data![index].title.toString()),
                              Text('Description:\n'+postList[index].body.toString())
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
