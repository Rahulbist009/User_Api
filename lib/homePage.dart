import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:user_api_get/utils/user_Model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Api'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {

              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReuseableRow(title: 'name', value: snapshot.data![index].name.toString()),
                              ReuseableRow(title: 'username', value: snapshot.data![index].username.toString()),
                              ReuseableRow(title: 'email', value: snapshot.data![index].email.toString()),
                              ReuseableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                               ReuseableRow(title: 'Geo', value:  snapshot.data![index].address!.geo!.lat.toString())    ,
                            ],
                          ),
                        ),
                      );
                    });
              }

            },
          ))
        ],
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {

  String title,value;
   ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
