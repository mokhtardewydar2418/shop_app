
import 'package:marketing/models/change_favorites_model.dart';
import 'package:marketing/models/home_model.dart';
import 'package:marketing/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopHomeSuccessDataState extends ShopStates{}

class ShopHomeErrorDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;

  ShopChangeFavoritesSuccessState(this.changeFavoritesModel);

}

class ShopChangeFavoritesErrorState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopGetFavoritesLoadingState extends ShopStates{}


class ShopGetFavoritesSuccessState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates{}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataSuccessState extends ShopStates
{
  final LoginModel userModel;

  ShopGetUserDataSuccessState(this.userModel);
}

class ShopGetUserDataErrorState extends ShopStates{}

class ShopUpdateUserDataLoadingState extends ShopStates{}

class ShopUpdateUserDataSuccessState extends ShopStates
{
  final LoginModel userModel;

  ShopUpdateUserDataSuccessState(this.userModel);
}

class ShopUpdateUserDataErrorState extends ShopStates{}


