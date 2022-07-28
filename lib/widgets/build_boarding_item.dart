import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(
        image: AssetImage(model.image),
      )),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 30.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}
