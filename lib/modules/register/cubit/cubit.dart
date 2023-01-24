
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/models/register_model.dart';
import 'package:marketing/modules/register/cubit/states.dart';
import 'package:marketing/shared/network/end_points.dart';
import 'package:marketing/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) =>BlocProvider.of(context);

  IconData visibility = Icons.visibility;
  bool isShow = true;
  void passwordVisibility()
  {
    isShow = !isShow;
    visibility = !isShow ? Icons.visibility : Icons.visibility_off;

    emit(RegisterPasswordVisibility());

  }

  RegisterModel registerModel;
  void getRegisterData({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
})
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'phone' : phone,
          'email' : email,
          'password' : password
        }
    ).then((value)
    {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }
    ).catchError((error)
    {
      emit(RegisterErrorState(error));
    }
    );
  }
}