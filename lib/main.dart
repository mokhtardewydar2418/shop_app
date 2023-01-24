import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:marketing/layout/home_layout.dart';
import 'package:marketing/modules/login/login_screen.dart';
import 'package:marketing/shared/bloc_observer.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/local/cache_helper.dart';
import 'package:marketing/shared/network/remote/dio_helper.dart';
import 'package:marketing/shared/style/themes.dart';

import 'modules/onBoarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool onBoard = CacheHelper.get(key: 'onBoard');
  token = CacheHelper.get(key: 'token');
  print(token);
  Widget widget;
  if(onBoard != null)
  {
    if(token != null)
    {
      widget = HomeLayoutScreen();
    }else
    {
      widget = LoginScreen();
    }
  }else
  {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    @required this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
