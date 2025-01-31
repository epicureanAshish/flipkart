import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:flipkart/ui/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late Product product;
  CartBloc cartBloc;
  ProductBloc(this.cartBloc) : super(ProductInitial()) {

    on<LoadProductEvent>(loadProductEvent);
    on<AddProductToCartEvent>(addProductToCartEvent);
    on<GoToCartEvent>(goToCartEvent);
    on<ProductCheckIfAddedToCartEvent>(productCheckIfAddedToCartEvent);
  }

  FutureOr<void> loadProductEvent(LoadProductEvent event, Emitter<ProductState> emit) {
    debugPrint("loadProductEvent");
    product = event.product;
    var temp = cartBloc.checkIfCartContainsItemEvent(event.product);
    emit(ProductLoadedState());
    emit(temp?ProductAddedToCartState():ProductNotAddedToCartState());
  }

  FutureOr<void> addProductToCartEvent(AddProductToCartEvent event, Emitter<ProductState> emit) {
    cartBloc.add(AddToCartItemsEvent(event.product));
    emit(ProductLoadedState());
  }

  FutureOr<void> goToCartEvent(GoToCartEvent event, Emitter<ProductState> emit) {
    emit(GoToCartActionState());
  }

  FutureOr<void> productCheckIfAddedToCartEvent(ProductCheckIfAddedToCartEvent event, Emitter<ProductState> emit) {
    var temp = cartBloc.checkIfCartContainsItemEvent(event.product);
    emit(temp?ProductAddedToCartState():ProductNotAddedToCartState());
  }


}
