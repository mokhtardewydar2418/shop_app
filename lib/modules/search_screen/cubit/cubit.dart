
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/models/search_model.dart';
import 'package:marketing/modules/search_screen/cubit/states.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/end_points.dart';
import 'package:marketing/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        lang: 'en',
        data:
        {
          'text' : text
        }
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    }
    );
  }
}