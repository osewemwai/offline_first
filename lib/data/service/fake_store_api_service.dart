import 'dart:convert';
import 'package:offline_first/data/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_store_api_service.g.dart';

@riverpod
class FakeStoreApiService extends _$FakeStoreApiService{

  final String baseUrl = 'https://fakestoreapi.com';

  @override
  FakeStoreApiService build() {
    return FakeStoreApiService();
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}