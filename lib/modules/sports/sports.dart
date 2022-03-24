
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit.dart';

import '../../layout/news_app/states.dart';
import '../../shared/componenets/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
        listener:(context,state){},
        builder:(context,state)
        {
          var list=NewsCubit.get(context).sports;
          return Articlebuilder(list,context);
        }
    );
  }
}
