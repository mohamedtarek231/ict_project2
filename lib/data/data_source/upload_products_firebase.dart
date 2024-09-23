import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/product_data_model.dart';
import 'package:http/http.dart' as http;

class UploadProductsFirebase {
//!==================================parameters===========================================
  List<ProductDataModel> productList = [];

//!==================================functions===========================================

  static Future<void> uploadProducts() async {
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> myProducts = jsonDecode(response.body);
      for (var items in myProducts) {
        saveProductsToFirebase(items);
      }
    }
  }

//!=============================================================================
  static Future saveProductsToFirebase(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('products').add(data);
    getProductsFromFirebase() {}
  }

// !=============================================================================

  Future<List<ProductDataModel>> getProductsFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> getProducts =
        await FirebaseFirestore.instance.collection('products').get();
    for (var element in getProducts.docs) {
      ProductDataModel model = ProductDataModel.fromMap(element.data());
      productList.add(model);
    }
    print('productListlinght ${productList.length}');
    return productList;
  }
}
