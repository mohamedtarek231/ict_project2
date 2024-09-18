import 'dart:convert';
import 'package:flutter_application_1/data/product_data_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSource {
  static bool isLoading = false;
  static bool isError = false;
  static List<ProductDataModel> ListOfProduct = [];

  static Future<bool> getProductsData() async {
    try {
      isLoading = true;
      ListOfProduct.clear();
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
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      isError = true;
      isLoading = false;
      print(e);
      print('failed to fetch data');
    }
    return false;
  }
}
