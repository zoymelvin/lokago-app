abstract class CartEvent {}

class FetchCartItems extends CartEvent {}

class AddToCart extends CartEvent {
  final String activityId;
  final int quantity;

  AddToCart({required this.activityId, required this.quantity});
}

class DeleteFromCart extends CartEvent {
  final String cartId;
  DeleteFromCart(this.cartId);
}