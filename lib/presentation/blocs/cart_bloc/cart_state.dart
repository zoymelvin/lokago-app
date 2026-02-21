import '../../../data/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartSuccess extends CartState {
  final List<CartItemModel> items;
  final int totalPrice;
  CartSuccess(this.items, this.totalPrice);
}
class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartActionSuccess extends CartState {
  final String message;
  CartActionSuccess(this.message);
}