import 'package:dio/dio.dart';
import 'package:ecommerce_seller/src/model/cart/cart_model.dart';
import 'package:ecommerce_seller/src/services/cart/cart_service.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final Dio dio;

  CartController(this.dio);

  late CartService cartService = CartService(dio);

  @override
  void onInit() {
    super.onInit();
    // getCart();
  }

  void clear(){
    cart = CartModel();
    cartStatus = Status.success;
  }

  CartModel _cart = CartModel();

  CartModel get cart => _cart;

  Status _cartStatus = Status.success;

  Status get cartStatus => _cartStatus;

  set cart(CartModel data) {
    _cart = data;
    update();
  }

  set cartStatus(Status data) {
    _cartStatus = data;
    update();
  }

  void increaseProductQuantity(String cartProductId, String productId) {
    if (cart.products?.isNotEmpty ?? false) {
      final product = cart.products!
          .firstWhere((e) => e.sId == cartProductId, orElse: null);

      if (product != null) {
        product.quantity = (product.quantity ?? 0) + 1;

        updateCartQuantity(
            productId: productId, quantity: product.quantity ?? 0);

        product.totalAmount = product.price! * product.quantity!;

        recalculateTotalPaidAmount();

        update();
      }
    }
  }

  void recalculateTotalPaidAmount() {
    double total = 0.0;

    cart.products?.forEach((product) {
      total += product.totalAmount ?? 0.0;
    });

    cart.totalPaidAmount = total + (cart.shippingPrice ?? 0);

    update();
  }

  void decreaseProductQuantity(String cartProductId, String productId) {
    if (cart.products?.isNotEmpty ?? false) {
      final product = cart.products!
          .firstWhere((e) => e.sId == cartProductId, orElse: null);

      if (product != null) {
        if ((product.quantity ?? 0) > 1) {
          product.quantity = (product.quantity ?? 1) - 1;

          updateCartQuantity(
              productId: productId, quantity: product.quantity ?? 0);

          product.totalAmount = product.price! * product.quantity!;

          recalculateTotalPaidAmount();
          update();
        } else {
          Helpers.cupertinoAlertPopUp(
            "This will remove this product from cart!",
            () {
              Get.back();
            },
            secondOption: true,
            optionText: "cancel",
            secondOptionText: "okay, remove",
            secondOnTap: () {
              removeProductFromCart(cartProductId);
              Get.back();
            },
          );
        }
      }
    }
  }

  void removeProductFromCart(String cartProductId) {
    if (cart.products?.isNotEmpty ?? false) {
      cart.products!.removeWhere((e) => e.sId == cartProductId);
      recalculateTotalPaidAmount();
      update();
    }
  }

  Future<void> getCart() async {
    cartStatus = Status.loading;

    final response = await cartService.getCart();

    response.fold((isFailure) {
      debugPrint(
          'Error in getCart : ${Helpers.convertFailureToMessage(isFailure)}');
      cartStatus = Status.failed;
    }, (success) {
      if (success['data'] != null) {
        CartModel cartData = CartModel.fromJson(success['data']);
        cart = cartData;
        cartStatus = Status.success;
      }
    });
  }

  Future<bool> addToCart(
      {required String productId,
      required String size,
      required int quantity}) async {
    final response = await cartService.addToCart(
        data: {"productId": productId, "size": size, "quantity": quantity});

    response.fold((isFailure) {
      debugPrint(
          'Error in addToCart : ${Helpers.convertFailureToMessage(isFailure)}');
    }, (success) {
      debugPrint('Added to cart');
    });
    return response.isRight();
  }

  Future<bool> updateCartQuantity(
      {required String productId, required int quantity}) async {
    final response = await cartService.updateCartQuantity(
        data: {"productId": productId, "quantity": quantity});

    response.fold((isFailure) {
      debugPrint(
          'Error in updateCart : ${Helpers.convertFailureToMessage(isFailure)}');
    }, (success) {
      debugPrint('Cart Updated');
    });
    return response.isRight();
  }

  Future<bool> deleteCardProductById(
      {required String productId, required String cartProductId}) async {
    final response =
        await cartService.deleteCardProductById(productId: productId);

    response.fold((isFailure) {
      debugPrint(
          'Error in deleteCardProductById : ${Helpers.convertFailureToMessage(isFailure)}');
    }, (success) {
      debugPrint('Success deleteCardProductById');
      removeProductFromCart(cartProductId);
    });
    return response.isRight();
  }
}
