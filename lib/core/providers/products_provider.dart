import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/products_model.dart';

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final productsName = [
    'iPhone',
    'iPad',
    'Mac',
    'Vision',
    'Apple TV',
    'HomePod',
    'iPod touch',
    'Apple Watch'
  ];
  Future<List<ProductModel>> list() async {
    return [
      ProductModel(
        id: '1',
        name: productsName[0],
        imageUrl: 'https://ipsw.me/assets/devices/iPhone17,1.png',
      ),
      ProductModel(
        id: '2',
        name: productsName[1],
        imageUrl: 'https://ipsw.me/assets/devices/iPad15,7.png',
      ),
      ProductModel(
        id: '3',
        name: productsName[2],
        imageUrl: 'https://ipsw.me/assets/devices/Mac16,13.png',
      ),
      ProductModel(
        id: '4',
        name: productsName[3],
        imageUrl: 'https://ipsw.me/assets/devices/RealityDevice14,1.png',
      ),
      ProductModel(
        id: '5',
        name: productsName[4],
        imageUrl: 'https://ipsw.me/assets/devices/AppleTV6,2.png',
      ),
      ProductModel(
        id: '6',
        name: productsName[5],
        imageUrl: 'https://ipsw.me/assets/devices/AudioAccessory5,1.png',
      ),
      ProductModel(
        id: '7',
        name: productsName[6],
        imageUrl: 'https://ipsw.me/assets/devices/iPod9,1.png',
      ),
      ProductModel(
        id: '8',
        name: productsName[7],
        imageUrl: 'https://ipsw.me/assets/devices/Watch5,4.png',
      ),
    ];
  }

  return await list();
});
