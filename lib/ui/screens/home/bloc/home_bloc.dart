import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<String> bannersList = [
    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202109/flipkart-big-billion-days-sale.jpg",
    "https://rukminim2.flixcart.com/fk-p-flap/480/300/image/77b34c9d49543223.jpeg?q=20",
    "https://rukminim2.flixcart.com/fk-p-flap/480/300/image/c43966bbada95f5d.jpeg?q=20",
    "https://rukminim2.flixcart.com/fk-p-flap/480/300/image/6e030e5f9b406b36.jpg?q=20",
    "https://rukminim2.flixcart.com/fk-p-flap/480/300/image/4b09c3c8164f0390.jpeg?q=20",
    "https://rukminim2.flixcart.com/fk-p-flap/480/300/image/7ba6bd924a005315.jpg?q=20"
  ];
  List<Map> categoriesList = [
    {
      "image_url":
          "https://rukminim2.flixcart.com/flap/64/64/image/29327f40e9c4d26b.png?q=100",
      "name": "Grocery"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/flap/64/64/image/22fddf3c7da4c4f4.png?q=100",
      "name": "Mobiles"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/64/64/image/0d75b34f7d8fbcb3.png?q=100",
      "name": "Fashion"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/flap/64/64/image/69c6589653afdb9a.png?q=100",
      "name": "Electronics"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/e2b3c05cdbd8ae6f.jpg?q=60",
      "name": "Home"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/flap/64/64/image/ab7e2b022a4587dd.jpg?q=100",
      "name": "Furniture"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/64/64/image/0139228b2f7eb413.jpg?q=100",
      "name": "Appliances"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/flap/64/64/image/71050627a56b4693.png?q=100",
      "name": "Travel"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/bf5504adae5eee4c.jpg?q=60",
      "name": "Gadgets"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/20ad6955f672a175.jpg?q=60",
      "name": "Beauty"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/ee559381b6ea7271.jpg?q=60",
      "name": "Food & Health"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/d682cf0128d92afa.png?q=60",
      "name": "Toys, Baby..."
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/a0e8d0f1c845b58e.jpg?q=60",
      "name": "2 Wheelers"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/498066194ca66480.jpg?q=60",
      "name": "Sports"
    },
    {
      "image_url":
          "https://rukminim2.flixcart.com/fk-p-flap/111/111/image/5ef719c9f2e281bd.jpg?q=60",
      "name": "Auto Acc"
    },
  ];

  HomeBloc() : super(HomeInitial()) {
    on<ProductTapEvent>(productTapEvent);
  }

  FutureOr<void> productTapEvent(
      ProductTapEvent event, Emitter<HomeState> emit) {
    emit(ProductTappedState(event.product));
  }
}
