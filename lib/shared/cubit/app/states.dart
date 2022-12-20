import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class LoadingHomeState extends AppStates {}

class SuccessHomeState extends AppStates {}

class ErrorHomeState extends AppStates {}

class SuccessCategoriesState extends AppStates {}

class ErrorCategoriesState extends AppStates {}

class ChangeFavoritesState extends AppStates {}

class SuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;

  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends AppStates {}

class LoadingGetFavoritesState extends AppStates {}

class SuccessGetFavoritesState extends AppStates {}

class ErrorGetFavoritesState extends AppStates {}

class LoadingGetUserDataState extends AppStates {}

class SuccessGetUserDataState extends AppStates {
  final LoginModel loginModel;

  SuccessGetUserDataState(this.loginModel);
}

class ErrorGetUserDataState extends AppStates {}

class LoadingUpdateUserDataState extends AppStates {}

class SuccessUpdateUserDataState extends AppStates {
  final LoginModel loginModel;

  SuccessUpdateUserDataState(this.loginModel);
}

class ErrorUpdateUserDataState extends AppStates {}

