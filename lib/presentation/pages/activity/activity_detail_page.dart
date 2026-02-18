import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/models/activity_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ActivityDetailMap(
                        address: widget.activity.address,
                        controller: _mapController,
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ActivityDetailBottomBar(activity: widget.activity),
        ],
      ),
    );
  }
}