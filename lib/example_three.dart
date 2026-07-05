import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api/models/nested_model.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<NestedModel> nestedList = [];

  Future<List<NestedModel>> getNestedApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        nestedList.add(NestedModel.fromJson(i));
      }
      return nestedList;
    }
    return nestedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REST API's")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getNestedApi(),
              builder: (context, AsyncSnapshot<List<NestedModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: nestedList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(index.toString()),
                                Text(snapshot.data![index].name.toString()),
                                Text(snapshot.data![index].username.toString()),
                                Text(snapshot.data![index].email.toString()),
                                Text(
                                  snapshot.data![index].address!.geo!.lat
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
