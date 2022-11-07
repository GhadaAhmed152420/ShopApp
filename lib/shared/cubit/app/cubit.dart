import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/views/favorites_screen.dart';
import 'package:shop_app/views/settings_screen.dart';
import '../../../models/categories_model.dart';
import '../../../models/home_model.dart';
import '../../../views/categories_screen.dart';
import '../../../views/products_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(LoadingHomeState());
    DioHelper.getData(
      url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners[0].image);
      emit(SuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoriesState());
    });
  }
}
