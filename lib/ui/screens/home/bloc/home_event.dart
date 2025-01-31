part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ProductTapEvent extends HomeEvent{
  Product product;
  ProductTapEvent(this.product);
}
