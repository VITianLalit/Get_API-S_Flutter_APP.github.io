import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/ProductsModel.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {

  Future<ProductsModel> getProductsApi () async{
    final response = await http.get(Uri.parse('https://webhook.site/847512cf-cded-4e33-a212-f67efbf482f1'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('API Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getProductsApi(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context,index){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.data![index].shop!.name.toString()),
                              subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height*.3,
                              width: MediaQuery.of(context).size.width*1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data![index].images!.length,
                                  itemBuilder:(context,position){
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*.25,
                                    width: MediaQuery.of(context).size.width*.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                      )
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite:Icons.favorite_outline)
                          ],
                        );
                      });
                }else{
                  return Text('Loading');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
