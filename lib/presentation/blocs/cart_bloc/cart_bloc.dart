import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../../data/repositories/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<FetchCartItems>((event, emit) async {
      if (state is! CartSuccess) emit(CartLoading());
      
      try {
        final items = await repository.getCartItems();
        if (items.isEmpty) {
          emit(CartSuccess(const [], 0));
        } else {
          items.sort((a, b) => a.id.compareTo(b.id));
          
          final total = items.fold<int>(0, (sum, item) {
            return sum + (item.activity.price * item.quantity);
          });
          emit(CartSuccess(items, total));
        }
      } catch (e) {
        emit(CartError("Gagal memuat data: ${e.toString()}"));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        await repository.updateCartQty(
          activityId: event.activityId,
          quantity: 1, 
        );
        
        await Future.delayed(const Duration(milliseconds: 300));
        
        add(FetchCartItems()); 
        
      } catch (e) {
        print("Update Error: $e");
      }
    });

    on<DeleteFromCart>((event, emit) async {
      try {
        await repository.deleteCartItem(event.cartId);
        add(FetchCartItems());
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}