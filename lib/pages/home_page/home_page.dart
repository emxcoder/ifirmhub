import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifirmhub/services/internet/network_provider.dart';
import 'package:ifirmhub/shared/widgets/texts.dart';
import '../../core/providers/products_provider.dart';
import '../../shared/widgets/appbars.dart';
import 'product_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final internetCheck = ref.watch(internetStatusProvider);
    bool status = internetCheck.value != null && internetCheck.value == true;

    return Scaffold(
      appBar: !status
          ? AppBar(
              title: Text(
                'iFirmHUB',
              ),
              centerTitle: true,
            )
          : topAppBar,
      body: Stack(
        children: [
          Column(
            children: [
              choosePText,
              if (!status) LinearProgressIndicator(),
              products.when(
                data: (products) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: RefreshIndicator(
                        onRefresh: () {
                          return ref.refresh(productsProvider.future);
                        },
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 600
                                    ? 4
                                    : 2, // 2 colunas
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            if (!status) {
                              return Card(
                                child: Center(
                                  child: Icon(Icons.devices),
                                ),
                              );
                            }
                            return ProductCard(productModel: product);
                          },
                        ),
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text('Erro $error'),
                  );
                },
                loading: () {
                  return Visibility(
                    visible: false,
                    child: Text(''),
                  );
                },
              ),
              // Visibility(
              //   visible: true,
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //         onPressed: () {}, child: Text('Tools and Guide')),
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
