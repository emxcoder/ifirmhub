import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/products_model.dart';

final productsProvider = Provider<List<Product>>((ref) {
  final productsName = [
    'iPhone',
    'iPad',
    'Mac',
    'Vision',
    'Apple TV',
    'HomePod',
    'iPad touch',
    'Apple Watch'
  ];

  return [
    Product(
      id: '1',
      name: productsName[0],
      imageUrl: 'https://ipsw.me/assets/devices/iPhone17,1.png',
    ),
    Product(
      id: '2',
      name: productsName[1],
      imageUrl: 'https://ipsw.me/assets/devices/iPad15,7.png',
    ),
    Product(
      id: '3',
      name: productsName[2],
      imageUrl: 'https://ipsw.me/assets/devices/Mac16,13.png',
    ),
    Product(
      id: '4',
      name: productsName[3],
      imageUrl: 'https://ipsw.me/assets/devices/RealityDevice14,1.png',
    ),
    Product(
      id: '5',
      name: productsName[4],
      imageUrl: 'https://ipsw.me/assets/devices/AppleTV6,2.png',
    ),
    Product(
      id: '6',
      name: productsName[5],
      imageUrl: 'https://ipsw.me/assets/devices/AudioAccessory5,1.png',
    ),
    Product(
      id: '7',
      name: productsName[6],
      imageUrl: 'https://ipsw.me/assets/devices/iPod9,1.png',
    ),
    Product(
      id: '8',
      name: productsName[7],
      imageUrl: 'https://ipsw.me/assets/devices/Watch5,4.png',
    ),
  ];
});
