abstract class PaymentEvent {}

class FetchPaymentMethods extends PaymentEvent {}

class CreateTransaction extends PaymentEvent {
  final String cartId;
  final String paymentMethodId;

  CreateTransaction({required this.cartId, required this.paymentMethodId});
}