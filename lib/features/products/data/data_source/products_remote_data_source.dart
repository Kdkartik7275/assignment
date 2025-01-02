import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_assignment/features/products/data/models/product.dart';

abstract interface class ProductsRemoteDataSource {
  Future<List<ProductModel>> fetchDummyProducts();
}

class ProductRemoteDataSrcImpl implements ProductsRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSrcImpl({required this.client});
  @override
  Future<List<ProductModel>> fetchDummyProducts() async {
    try {
      List<ProductModel> prods = [];

      const api = 'https://dummyjson.com/products';

      final response = await client.get(Uri.parse(api));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = data['products'];
        for (var product in products) {
          prods.add(ProductModel.fromJson(product));
        }
      } else {
        throw Exception('Failed to fetch data');
      }
      return prods;
    } catch (e) {
      throw e.toString();
    }
  }
}
