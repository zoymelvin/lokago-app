import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/widgets/cart/cart_item_card.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/cart_bloc/cart_event.dart';
import '../../blocs/cart_bloc/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text("Keranjang Saya", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is! CartActionSuccess,
        builder: (context, state) {
          if (state is CartLoading && state is! CartSuccess) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartSuccess) {
            if (state.items.isEmpty) return _buildEmptyState();

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
              itemCount: state.items.length + 1,
              itemBuilder: (context, index) {
                if (index == state.items.length) return const SizedBox(height: 100);
                
                final item = state.items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CartItemCard(
                    key: ValueKey(item.id),
                    item: item,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text("Keranjang kosong", style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}