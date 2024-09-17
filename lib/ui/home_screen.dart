import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product_data_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isError = false;
  Future<void> getProductsData() async {
    try {
      isLoading = true;
      ListOfProduct.clear();
      setState(() {});
      final uri = Uri.parse('https://fakestoreapi.com/products');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> ListOfObjects = jsonDecode(response.body);

        for (Map<String, dynamic> object in ListOfObjects) {
          ProductDataModel product = ProductDataModel(
            title: object['title'],
            description: object['description'],
            image: object['image'],
            price: object['price'].toDouble(),
          );
          ListOfProduct.add(product);
        }
        isLoading = false;
        print(ListOfObjects.length);
        setState(() {});
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('failed to fetch data');
    }
  }

  List<ProductDataModel> ListOfProduct = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ListOfProduct.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    ListOfProduct[index].image ?? '',
                    width: 50,
                    height: 100,
                  ),
                  title: Text(
                    ListOfProduct[index].title ?? 'no title',
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    ListOfProduct[index].description ?? 'no description',
                    maxLines: 2,
                  ),
                  trailing: Text('${ListOfProduct[index].price ?? 0.0}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : getProductsData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
