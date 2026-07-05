import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api/models/products_model.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    }
    return ProductsModel.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FETCH PRODUCTS USING API"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.products!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 500,
                          width: 250,
                          color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot.data!.products![index].images![0]
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.data!.products![index].title
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                snapshot.data!.products![index].description
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
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
