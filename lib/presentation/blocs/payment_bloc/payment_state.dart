import '../../../data/models/payment_method_model.dart';
import '../../../data/models/transaction_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentMethodsSuccess extends PaymentState {
  final List<PaymentMethodModel> methods;
  PaymentMethodsSuccess(this.methods);
}

class TransactionSuccess extends PaymentState {
  final TransactionModel transaction;
  TransactionSuccess(this.transaction);
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}