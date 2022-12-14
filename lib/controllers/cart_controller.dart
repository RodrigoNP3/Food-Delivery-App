// import 'dart:html';

import 'package:food_delivery_v0/models/cart_model.dart';
import 'package:food_delivery_v0/models/product_model.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
//for storage and sharedpreferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = (value.quantity! + quantity);
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
      update();
      Get.snackbar('Item updated to Cart', 'Item updated to cart successfuly!');
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            Get.snackbar(
                'Item Added to Cart', 'Item added to cart successfuly!');
            return CartModel(
              id: product.id!,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product,
            );
          },
        );
      } else {
        Get.snackbar(
            'Item Count', 'You should at least add an item in the cart');
      }
      cartRepo.addToCartList(getItems);
      update();
    }
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += (value.quantity! * value.price!);
    });
    return total;
  }

  List<CartModel> getCartData() {
    // storageItems = [];
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    // print('The lenght of the cart items is: ${storageItems.length.toString()}');
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
