import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import '../models/categories_model.dart';
import '../shared/cubit/app/cubit.dart';
import '../shared/cubit/app/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SuccessChangeFavoritesState) {
          if (!state.model.status!) {
            showToast(message: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel != null &&
              AppCubit.get(context).categoriesModel != null,
          builder: (BuildContext context) => productsBuilder(
              AppCubit.get(context).homeModel,
              AppCubit.get(context).categoriesModel,
              context),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map(
                      (e) => Image(
                        image: NetworkImage(e.image),
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel!.data!.data[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10.0),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.61,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );
}

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100.0,
          height: 25.0,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              model.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );

Widget buildGridProduct(ProductModel? model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice} ',
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
                          AppCubit.get(context).favorites[model.id]!
                              ? Colors.deepPurple
                              : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            AppCubit.get(context).changeFavorites(model.id);
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
    );
