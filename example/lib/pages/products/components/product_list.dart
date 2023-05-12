import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_test/pages/products/product_page_controller.dart';

class ProductList extends HookConsumerWidget {
  final void Function()? onTap;
  const ProductList({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(productPageControllerProvider.notifier);
    return ListView.separated(
      itemBuilder: (context, int index) {
        final product = controller.products[index];
        return ListTile(
          dense: false,
          selected: controller.selectedProduct == product,
          leading: CircleAvatar(
            backgroundImage: AssetImage(product.photoUrl),
          ),
          title: Text(product.title),
          subtitle: Text(
            product.description,
            maxLines: 2,
          ),
          trailing: Text('${product.price} руб'),
          onTap: () {
            controller.selectedProduct = product;
            onTap!();
          },
          isThreeLine: false,
        );
      },
      separatorBuilder: (context, int index) {
        return const Divider();
      },
      itemCount: controller.products.length,
    );
  }
}
