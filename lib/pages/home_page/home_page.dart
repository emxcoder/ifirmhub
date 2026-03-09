import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ifirmhub/core/utils/utils.dart';
import '../../constants/constants.dart';
import '../../core/providers/products_provider.dart';
import '../../services/internet/network_provider.dart';
import '../../shared/widgets/appbars.dart';
import '../../shared/widgets/texts.dart';
import 'product_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final hasInternet = hasInternetGlobal(ref);

    return Scaffold(
      appBar: topAppBar,
      body: Column(
        children: [
          choosePText,
          if (!hasInternet || products.isLoading) LinearProgressIndicator(),
          products.when(
            data: (products) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: RefreshIndicator(
                    onRefresh: () {
                      ref.invalidate(internetStatusProvider);
                      return ref.refresh(productsProvider.future);
                    },
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
                        return InkWell(
                          onTap: () {
                            if (!hasInternet) {
                              counterTryState(ref).state++;
                              if (counterTry(ref) < 4) {
                                notificationService.showOffline(context);
                              }
                            } else {
                              counterTryState(ref).state = 0;
                              context.pushNamed('device_page',
                                  pathParameters: {'type': product.name},
                                  extra: product);
                            }
                          },
                          borderRadius: BorderRadius.circular(16),
                          splashColor: Colors.lightBlue,
                          focusColor: Colors.amber,
                          onLongPress: () {},
                          child: !hasInternet
                              ? ProductCard2(productModel: product)
                              : ProductCard(productModel: product),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) {
              return Scaffold(
                body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Erro Loading Products')]),
                ),
              );
            },
            loading: () {
              return Scaffold(
                backgroundColor: Colors.blue.shade600,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
