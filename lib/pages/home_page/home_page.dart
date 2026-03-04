import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifirmhub/shared/widgets/texts.dart';
import '../../core/providers/products_provider.dart';
import '../../shared/widgets/appbars.dart';
import 'product_page/product_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      appBar: topAppBar,
      body: Column(
        children: [
          chooseText,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600
                      ? 4
                      : 2, // 2 colunas
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
