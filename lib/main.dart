import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/layout/news_app/cubit.dart';
import 'package:news/layout/news_app/news_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/states.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/network/local/chache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bloc/bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? DarkMode = CacheHelper.getBool(key:'DarkMode');

  BlocOverrides.runZoned(
    (){
      runApp( MyApp(DarkMode==null?false:DarkMode));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool DarkMode;
  MyApp(this.DarkMode);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience()..ChangeDarkMode(
      Dark: DarkMode,
      ),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.teal,
                    size: 30,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.teal,
                  unselectedItemColor: Colors.grey,
                  elevation: 100,
                  backgroundColor: Colors.white,
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))),
            darkTheme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: AppBarTheme(
                  backgroundColor: HexColor('404040'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('404040'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                scaffoldBackgroundColor: HexColor('404040'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.teal,
                  unselectedItemColor: Colors.grey,
                  elevation: 100,
                  backgroundColor: HexColor('404040'),
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ) //override عليه
                    )),
            themeMode:NewsCubit.get(context).DarkMode ? ThemeMode.dark : ThemeMode.light,
            home: NewsApp(),
          );
        },
      ),
    );
  }
}
