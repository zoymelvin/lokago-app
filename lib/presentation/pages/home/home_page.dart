import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../blocs/user_bloc/user_bloc.dart'; 
import '../../blocs/user_bloc/user_state.dart'; 
import '../../widgets/home/home_search_bar.dart';
import '../../widgets/home/home_category_section.dart';
import '../../widgets/home/activity_grid.dart';
import '../../widgets/home/home_featured_banner.dart';
import '../../widgets/home/home_quick_filters.dart';
import '../../../data/models/activity_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;
  Timer? _timer;
  List<ActivityModel> _featuredActivities = [];

  void _setupFeaturedActivities(List<ActivityModel> activities) {
    final targetKeywords = ['Nusa Penida indah', 'Liburan di Bali', 'Sea World Ancols', 'Lake Toba'];

    final filtered = activities.where((act) {
      return targetKeywords.any((key) => act.title.toLowerCase().contains(key.toLowerCase())) &&
             act.imageUrls.isNotEmpty && !act.imageUrls[0].contains('example.com');
    }).toList();

    if (filtered.length < 5) {
      final others = activities.where((act) => !filtered.contains(act) && act.imageUrls.isNotEmpty).toList();
      others.sort((a, b) => b.rating.compareTo(a.rating));
      filtered.addAll(others.take(5 - filtered.length));
    }

    if (_featuredActivities.isEmpty && filtered.isNotEmpty) {
      _featuredActivities = filtered;
      _startBannerTimer();
    }
  }

  void _startBannerTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) setState(() => _currentBannerIndex = (_currentBannerIndex + 1) % _featuredActivities.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            _setupFeaturedActivities(state.activities);

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HomeSearchBar(),
                    ),
                    const SizedBox(height: 15), 
                    const HomeQuickFilters(),
                    const SizedBox(height: 15),

                    if (_featuredActivities.isNotEmpty)
                      HomeFeaturedBanner(activity: _featuredActivities[_currentBannerIndex]),

                    const SizedBox(height: 20),
                    _buildTitle("Jelajahi Dunia Lebih Hemat"),
                    const SizedBox(height: 10),
                    HomeCategorySection(categories: state.categories),
                    
                    const SizedBox(height: 20),
                    _buildTitle("Rekomendasi Liburan"),
                    ActivityGrid(activities: state.activities),
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(color: Color(0xFF0052CC)));
        },
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87)),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("LokaGo", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF0052CC))),
          Row(
            children: [
              const SizedBox(width: 12),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  String imageUrl = "https://i.pravatar.cc/150";
                  
                  if (state is UserSuccess) {
                    imageUrl = state.user.profilePictureUrl ?? imageUrl;
                  }

                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF0052CC),
                    backgroundImage: NetworkImage(imageUrl),
                    onBackgroundImageError: (_, __) => const Icon(Icons.person, color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}