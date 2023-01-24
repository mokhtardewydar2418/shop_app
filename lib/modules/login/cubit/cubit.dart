import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/models/login_model.dart';
import 'package:marketing/modules/login/cubit/states.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/end_points.dart';
import 'package:marketing/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  IconData visibility = Icons.visibility;
  bool isShow = true;
  void passwordVisibility()
  {
    isShow = !isShow;
    visibility = !isShow ? Icons.visibility : Icons.visibility_off;

    emit(LoginPasswordVisibility());

  }

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
})
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email' : email,
          'password' : password
        },
    ).then((value)
    {
      print(value.data['message']);
      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel));
    }
    ).catchError((error)
    {
      emit(LoginErrorState(error));
    }
    );
  }
}