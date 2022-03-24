import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit.dart';
import 'package:news/layout/news_app/states.dart';
import '../../shared/componenets/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
        listener:(context,state){},
        builder:(context,state)
        {
          var list=NewsCubit.get(context).business;
          return Articlebuilder(list,context);

        }
    );
  }
}