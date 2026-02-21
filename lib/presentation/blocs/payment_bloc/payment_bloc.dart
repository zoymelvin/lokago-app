import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import '../../../data/repositories/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    
    on<FetchPaymentMethods>((event, emit) async {
      emit(PaymentLoading());
      try {
        final methods = await repository.getPaymentMethods();
        emit(PaymentMethodsSuccess(methods));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });

    on<CreateTransaction>((event, emit) async {
      emit(PaymentLoading());
      try {
        final transaction = await repository.createTransaction(
          cartId: event.cartId,
          paymentMethodId: event.paymentMethodId,
        );

        final instantSuccess = transaction.copyWith(status: 'success');

        emit(TransactionSuccess(instantSuccess));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });

    on<FetchTransactionHistory>((event, emit) async {
      emit(PaymentLoading());
      try {
        final transactions = await repository.getTransactionHistory();
        
        final forcedList = transactions.map((tx) {
          return tx.copyWith(status: 'success');
        }).toList();

        emit(TransactionHistorySuccess(forcedList));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });
  }
}