import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import '../widgets/custom_textfield.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final controller = ProductController();
  final searchController = TextEditingController();

  List<Product> products = [];
  bool isLoading = false;

  void search(String keyword) async {
    if (keyword.isEmpty) {
      setState(() => products = []);
      return;
    }

    setState(() => isLoading = true);

    final result = await controller.searchProducts(keyword);

    setState(() {
      products = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // MÃ SINH VIÊN
            Text(
              '6451071077',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            CustomTextField(
              controller: searchController,
              hint: 'Nhập từ khóa...',
              onChanged: search,
            ),

            SizedBox(height: 10),

            if (isLoading)
              CircularProgressIndicator(),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];

                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text('\$${item.price}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}