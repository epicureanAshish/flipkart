part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeActionState extends HomeState {}

class ProductTappedState extends HomeActionState{
  Product product;
  ProductTappedState(this.product);
}

