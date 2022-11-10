import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
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
              itemBuilder: (context, index) => buildFavItem(AppCubit.get(context).favoritesModel!.data!.data![index], context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: AppCubit.get(context).favoritesModel!.data!.data!.length), fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                   Image(
                    image: NetworkImage("${model.product!.image}"),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "${model.product!.name}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                         Text(
                          "${model.product!.price}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product!.discount != 0)
                           Text(
                            "${model.product!.oldPrice}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              AppCubit.get(context).favorites[model.product!.id]! ? Colors.deepPurple : Colors.grey,
                          child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).changeFavorites(model.product!.id!);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 14.0,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
