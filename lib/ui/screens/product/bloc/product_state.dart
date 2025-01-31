part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

abstract class ProductActionState extends ProductState{}

class ProductInitial extends ProductState {}

class ProductLoadedState extends ProductState {}

class ProductAddedToCartState extends ProductState {}

class ProductNotAddedToCartState extends ProductState {}

class GoToCartActionState extends ProductActionState {}
