import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/shop_cubit/states.dart';
import 'package:marketing/models/change_favorites_model.dart';
import 'package:marketing/models/favorites_model.dart';
import 'package:marketing/models/home_model.dart';
import 'package:marketing/models/login_model.dart';
import 'package:marketing/modules/categories_screen/categories_screen.dart';
import 'package:marketing/modules/favorites_screen/favorites_screen.dart';
import 'package:marketing/modules/products_screen/products_screen.dart';
import 'package:marketing/modules/settings_screen/settings_screen.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/end_points.dart';
import 'package:marketing/shared/network/remote/dio_helper.dart';

import '../../models/categories_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0 ;
  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  List<Widget> screens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<String> titles =
  [
    'Products',
    'Categories',
    'Favorites',
    'Settings',
  ];
  List<BottomNavigationBarItem> bottomNavItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.production_quantity_limits),
      label: 'Products'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];

  HomeModel homeModel;

  Map<int,bool> favorites = {};
  void getHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
      lang: 'en'
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll(
            {
              element.id : element.in_favorites
            }
        );
      }
      );

      print(favorites.toString());

      emit(ShopHomeSuccessDataState());
    }
    ).catchError((error)
    {
      print('Error While Getting HomeData : ${error.toString()} ');
      emit(ShopHomeErrorDataState());
    }
    );
  }

  CategoriesModel categoriesModel;
  void getCategoriesData()
  {
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token,
        lang: 'en'
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }
    ).catchError((error)
    {
      print('Error While Getting Categories Data : ${error.toString()}');
      emit(ShopErrorCategoriesState());
    }
    );
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int id)
  {
    favorites[id] = !favorites[id];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        lang: 'en',
        data:
        {
          'product_id' : id
        }
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel.status)
      {
        favorites[id] = !favorites[id];
      }else
      {
        getFavorites();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel));
    }
    ).catchError((error)
    {
      favorites[id] = !favorites[id];

      emit(ShopChangeFavoritesErrorState());
    }
    );
  }

  GetFavoritesModel getFavoritesModel;
  void getFavorites()
  {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
      lang: 'en'
    ).then((value)
    {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }
    ).catchError((error)
    {
      emit(ShopGetFavoritesErrorState());
    }
    );
  }

  LoginModel userModel;
  void getUserData()
  {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
        lang: 'en'
    ).then((value)
    {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState(userModel));
      print(userModel.data.name);
    }
    ).catchError((error)
    {
      emit(ShopGetUserDataErrorState());
    }
    );
  }

  void updateUserData({
    @required String name,
    @required String phone,
    @required String email,
})
  {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data:
        {
          'name' : name,
          'email' : email,
          'phone' : phone
        },
        token: token,
    ).then((value)
    {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopUpdateUserDataSuccessState(userModel));
      print(userModel.data.name);
    }
    ).catchError((error)
    {
      emit(ShopUpdateUserDataErrorState());
    }
    );
  }





}