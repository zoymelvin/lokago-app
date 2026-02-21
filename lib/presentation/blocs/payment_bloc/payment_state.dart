import 'package:equatable/equatable.dart';
import '../../../data/models/payment_method_model.dart';
import '../../../data/models/transaction_model.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentMethodsSuccess extends PaymentState {
  final List<PaymentMethodModel> methods;
  PaymentMethodsSuccess(this.methods);

  @override
  List<Object?> get props => [methods];
}

class TransactionSuccess extends PaymentState {
  final TransactionModel transaction;
  TransactionSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionHistorySuccess extends PaymentState {
  final List<TransactionModel> transactions;
  TransactionHistorySuccess(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}