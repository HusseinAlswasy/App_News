import 'package:flutter/material.dart';
import 'package:news/layout/news_app/cubit.dart';
import 'package:news/layout/news_app/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/componenets/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, builder) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty.';
                    }
                    return null;
                  },
                ),
                Expanded(child: Articlebuilder(list,context,isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
