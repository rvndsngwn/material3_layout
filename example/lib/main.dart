import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material3_layout/material3_layout.dart';
import 'package:package_test/pages/products/components/details_page.dart';
import 'package:package_test/pages/products/components/product_list.dart';
import 'package:package_test/pages/products/product_page_controller.dart';

import 'pages/products/product_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

ValueNotifier<ThemeMode> currentTheme = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: currentTheme,
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.green,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
          ),
          themeMode: theme,
          home: const ScreenWidget(),
        );
      },
    );
  }
}

class ScreenWidget extends HookConsumerWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProduct = ref.watch(productPageControllerProvider);
    final destinations = <DestinationModel>[
      DestinationModel(
        label: 'Products',
        selectedIcon: const Icon(Icons.storefront),
        icon: const Icon(Icons.storefront),
        tooltip: 'Products page',
      ),
      DestinationModel(
          label: 'Clients',
          selectedIcon: const Icon(Icons.group),
          badge: const Badge(
            child: Icon(Icons.group_outlined),
          ),
          tooltip: 'Clients page'),
    ];

    final pages = <PageLayout>[
      PageLayout(
        compactLayout: SinglePaneLayout(
          child: PaneContainerWidget(
            //   borderRadius: 0,
            child: ProductList(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                  ),
                );
              },
            ),
          ),
        ),
        mediumLayout: SinglePaneLayout(
          verticalPadding: 24,
          child: PaneContainerWidget(
            child: ProductList(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                  ),
                );
              },
            ),
          ),
        ),
        expandedLayout: TwoPaneLayout(
          verticalPadding: 24,
          fixedPaneChild: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 10),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: ListTile(
                  title: Text(
                    'Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      ref
                          .read(productPageControllerProvider.notifier)
                          .products
                          .add(
                            ProductModel(
                              title: 'Пицца Маргарита',
                              description:
                                  'томатный соус, моцарелла, пармезан, базилик, оливковое масло',
                              photoUrl: 'assets/margarita.jpeg',
                            ),
                          );
                    },
                  ),
                ),
              ),
              Expanded(
                child: PaneContainerWidget(
                  child: ProductList(
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          flexiblePaneChild: PaneContainerWidget(
            child: Center(
              child: selectedProduct?.photoUrl == null
                  ? const FlutterLogo(size: 200)
                  : Image.asset(selectedProduct?.photoUrl ?? ""),
            ),
          ),
        ),
      ),
      PageLayout(
        compactLayout: SinglePaneLayout(
          child: const PaneContainerWidget(
            child: Center(
              child: Text(
                'Compact layout',
              ),
            ),
          ),
        ),
        mediumLayout: SplitPaneLayout(
          verticalPadding: 24,
          leftChild: const PaneContainerWidget(
            surfaceColor: SurfaceColorEnum.surfaceContainerLow,
            child: Center(
              child: Text(
                'medium layout left child',
              ),
            ),
          ),
          rightChild: const PaneContainerWidget(
            surfaceColor: SurfaceColorEnum.surface,
            child: Center(
              child: Text(
                'medium layout right child',
              ),
            ),
          ),
        ),
        expandedLayout: const TwoPaneLayout(
          verticalPadding: 24,
          fixedPaneChild: PaneContainerWidget(
            surfaceColor: SurfaceColorEnum.surfaceContainerLow,
            child: Center(
              child: Text(
                'expanded layout fixed pane',
              ),
            ),
          ),
          flexiblePaneChild: PaneContainerWidget(
            child: Center(
              child: Text(
                'expanded layout flexible pane',
              ),
            ),
          ),
        ),
      ),
    ];
    final selectedIndex = useState(0);
    return NavigationScaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Awesome app'),
        centerTitle: true,
      ),
      onTapThemeSwitcherButton: () => currentTheme.value =
          currentTheme.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
      navigationType: NavigationTypeEnum.railAndBottomNavBar,
      navigationSettings: RailAndBottomSettings(
        addThemeSwitcherTrailingIcon: false,
        showMenuIcon: true,
        destinations: destinations,
        body: pages[selectedIndex.value],
      ),
      theme: Theme.of(context),
      selectedIndex: selectedIndex.value,
      onDestinationSelected: (int index) {
        log(
          'Page changed: Current page: $index',
        );
        selectedIndex.value = index;
      },
    );
  }
}
