import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/core/utils/formatter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/models/activity_model.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/cart_bloc/cart_event.dart';
import '../../blocs/cart_bloc/cart_state.dart';
import '../payment/payment_page.dart';
import 'widgets/activity_detail_header.dart';
import 'widgets/activity_detail_info.dart';
import 'widgets/activity_detail_description.dart';
import 'widgets/activity_detail_map.dart';
import 'widgets/activity_detail_bottom_bar.dart';

class ActivityDetailPage extends StatefulWidget {
  final ActivityModel activity;
  const ActivityDetailPage({super.key, required this.activity});

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late final WebViewController _mapController;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _mapController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(
        """
        <!DOCTYPE html>
        <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>body { margin: 0; padding: 0; overflow: hidden; } iframe { width: 100vw; height: 100vh; border: none; }</style>
          </head>
          <body>${widget.activity.locationMaps}</body>
        </html>
        """
      );
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
                  const SizedBox(height: 24),
                  Text("Pesan Tiket", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.activity.title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jumlah Tiket", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(widget.activity.price.toRupiah(), style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            IconButton(onPressed: quantity > 1 ? () => setModalState(() => quantity--) : null, icon: const Icon(Icons.remove, size: 20)),
                            Text("$quantity", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            IconButton(onPressed: () => setModalState(() => quantity++), icon: const Icon(Icons.add, size: 20, color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Harga", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text((widget.activity.price * quantity).toRupiah(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity, height: 54,
                    child: BlocConsumer<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is CartActionSuccess) {
                          Navigator.pop(context);
                          context.read<CartBloc>().add(FetchCartItems());
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is CartLoading 
                            ? null 
                            : () {
                                context.read<CartBloc>().add(
                                  AddToCart(activityId: widget.activity.id, quantity: quantity)
                                );
                              },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, 
                            foregroundColor: Colors.white, 
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), 
                            elevation: 0
                          ),
                          child: state is CartLoading 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text("Konfirmasi Pemesanan", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartSuccess) {
          try {
            final newItem = state.items.firstWhere(
              (element) => element.activity.id == widget.activity.id,
            );
            
            if (mounted) {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PaymentPage(cartItem: newItem))
              );
            }
          } catch (e) {
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityDetailHeader(activity: widget.activity),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ActivityDetailInfo(activity: widget.activity),
                        const SizedBox(height: 25),
                        ActivityDetailDescription(activity: widget.activity),
                        const SizedBox(height: 25),
                        ActivityDetailMap(address: widget.activity.address, controller: _mapController),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ActivityDetailBottomBar(
              activity: widget.activity, 
              onBookNowPressed: _showBookingBottomSheet,
            ),
          ],
        ),
      ),
    );
  }
}