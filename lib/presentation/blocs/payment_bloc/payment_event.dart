import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPaymentMethods extends PaymentEvent {}

class CreateTransaction extends PaymentEvent {
  final String cartId;
  final String paymentMethodId;

  CreateTransaction({required this.cartId, required this.paymentMethodId});

  @override
  List<Object?> get props => [cartId, paymentMethodId];
}

class FetchTransactionHistory extends PaymentEvent {}