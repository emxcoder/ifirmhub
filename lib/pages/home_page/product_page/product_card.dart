import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifirmhub/services/internet/network_provider.dart';
import '../../../core/models/products_model.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetCheck = ref.watch(internetStatusProvider);
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: internetCheck.when(
                    data: (data) {
                      return Image.network(
                        semanticLabel: product.name,
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    error: (error, stackTrace) {
                      return Icon(Icons.devices);
                    },
                    loading: () {
                      return Icon(Icons.devices);
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
