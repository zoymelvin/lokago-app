import '../../../data/models/banner_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/activity_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ActivityModel> activities;

  HomeSuccess({
    required this.banners,
    required this.categories,
    required this.activities,
  });
}

class HomeError extends HomeState {
  final String errorMessage;
  HomeError(this.errorMessage);
}