part of 'cart_bloc.dart';

abstract class CartEvent {}

class FetchCartItemsEvent extends CartEvent{}

class AddToCartItemsEvent extends CartEvent{
  Product product;
  AddToCartItemsEvent(this.product);
}

class RemoveFromCartItemsEvent extends CartEvent{
  Product product;
  RemoveFromCartItemsEvent(this.product);
}
