import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import '../shared/components/components.dart';
import '../shared/cubit/app/cubit.dart';
import '../shared/cubit/app/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetFavoritesState,
          builder:(context) => ListView.separated(
              itemBuilder: (context, index) => buildProductList(AppCubit.get(context).favoritesModel!.data!.data![index].product!, context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: AppCubit.get(context).favoritesModel!.data!.data!.length), fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
