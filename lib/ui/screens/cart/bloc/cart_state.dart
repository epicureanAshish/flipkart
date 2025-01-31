part of 'cart_bloc.dart';

abstract class CartState {
  late List<Product> cartItems;
}

class CartInitial extends CartState {}

class CartLoadedState extends CartState{
  List<Product> cartItems;
  CartLoadedState(this.cartItems);
}

class AddedToCartState extends CartState{
  List<Product> cartItems;
  AddedToCartState(this.cartItems);
}

class RemovedFromCartState extends CartState{
  List<Product> cartItems;
  RemovedFromCartState(this.cartItems);
}
