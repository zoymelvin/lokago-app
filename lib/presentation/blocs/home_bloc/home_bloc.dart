import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/models/banner_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/activity_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<GetHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final results = await Future.wait([
          homeRepository.getBanners(),
          homeRepository.getCategories(),
          homeRepository.getActivities(),
        ]);

        final bannerResponse = results[0];
        final categoryResponse = results[1];
        final activityResponse = results[2];

        final List<BannerModel> banners = (bannerResponse.data['data'] as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();

        final List<CategoryModel> categories = (categoryResponse.data['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        final List<ActivityModel> activities = (activityResponse.data['data'] as List)
            .map((e) => ActivityModel.fromJson(e))
            .toList();

        emit(HomeSuccess(
          banners: banners,
          categories: categories,
          activities: activities,
        ));
      } catch (e) {
        emit(HomeError("Gagal memuat data beranda: ${e.toString()}"));
      }
    });
  }
}