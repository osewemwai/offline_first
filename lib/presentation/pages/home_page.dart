import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_first/data/service/fake_store_api_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(fakeStoreApiServiceProvider).getProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body:  FutureBuilder(
      future: productList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found'));
        } else {
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                leading: Image.network(product.image, width: 50, height: 50),
              );
            },
          );
        }
      },
      ),
    );
  }
}