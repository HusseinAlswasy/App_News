import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/states.dart';
import 'package:news/modules/buisness/buisness.dart';
import 'package:news/modules/science/science.dart';
import 'package:news/modules/sports/sports.dart';
import 'package:news/shared/network/local/chache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import '../../shared/network/local/chache_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int CurruntIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    CurruntIndex = index;
    emit(NewsBottomNavBarState());
  }


  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country' : 'eg',
        'category' : 'business',
        'apiKey' : '525f635890d140759bcf53a367f6ad71',
      },
    ).then((value) {
      business = value.data['articles'];
      print('Get Business Data Successfully');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print('Error When Get Business Data ===> ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'sports',
          'apiKey' : '525f635890d140759bcf53a367f6ad71',
        },
      ).then((value) {
        sports = value.data['articles'];
        print('Get Sports Data Successfully');
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print('Error When Get Sports Data ===> ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());

    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'science',
          'apiKey' : '525f635890d140759bcf53a367f6ad71',
        },
      ).then((value) {
        science = value.data['articles'];
        print('Get Sports Data Successfully');
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print('Error When Get Sports Data ===> ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceLoadingState());
    }
  }


  List search = [];
  void getSearch(String? value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q' : value!,
        'apiKey' : '525f635890d140759bcf53a367f6ad71',
      },
    ).then((value) {
      emit(NewsGetSearchSuccessState());
      search = value.data['articles'];
      print('Get Search Data Successfully');
    }).catchError((error){
      print('Error When Get Search Data ===> ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool DarkMode = false;

  void ChangeDarkMode({bool? Dark}) {
    if (Dark != null) {
      DarkMode = Dark;
      emit(NewsChnageModeState());
    } else {
      DarkMode = !DarkMode;
      CacheHelper.putBool(key: 'DarkMode', value: DarkMode).then((value) {
        emit(NewsChnageModeState());
      });
    }
  }
}
