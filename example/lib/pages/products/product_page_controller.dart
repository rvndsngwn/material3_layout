import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_test/pages/products/product_model.dart';

class ProductPageController extends StateNotifier<ProductModel?> {
  ProductPageController() : super(null);

  ProductModel get selectedProduct => state ?? products.first;
  set selectedProduct(ProductModel value) => state = value;

  final List<ProductModel> products = [
    ProductModel(
      title: 'Пицца Маргарита',
      description:
          'томатный соус, моцарелла, пармезан, базилик, оливковое масло',
      photoUrl: 'assets/margarita.jpeg',
    ),
    ProductModel(
        title: 'Пицца Фунги',
        description:
            'сливочный соус, моцарелла, шампиньоны, ассорти грибное, трюфельная паста, пармезан, укроп',
        photoUrl: 'assets/fungi.jpeg'),
    ProductModel(
      title: 'Пицца 4 сыра',
      description:
          'сливочный соус, моцарелла, сыр с плесенью, пармезан, сыр страчателла',
      photoUrl: 'assets/formagi.jpeg',
    ),
    ProductModel(
      title: 'Пицца Аля-Цезарь',
      description:
          'сливочный соус, соус цезарь, моцарелла, копченая курица, руккола, пармезан, томаты черри',
      photoUrl: 'assets/ala-scesar.jpeg',
    ),
    ProductModel(
      title: 'Пицца Капричиоза',
      description:
          'томатный соус, моцарелла, шампиньоны, орегано, вареная ветчина, артишоки, пармезан, оливковое масло',
      photoUrl: 'assets/caprichiosa.jpeg',
    ),
  ];
}

final productPageControllerProvider =
    StateNotifierProvider<ProductPageController, ProductModel?>(
        (ref) => ProductPageController());
