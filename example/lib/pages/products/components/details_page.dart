import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_test/pages/products/product_page_controller.dart';

class DetailsPage extends HookConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProduct = ref.watch(productPageControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(selectedProduct?.title ?? "No title")),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              selectedProduct?.photoUrl ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
