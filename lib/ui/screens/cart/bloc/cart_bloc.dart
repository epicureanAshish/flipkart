import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flipkart/data/cart_data/cart_data_service.dart';
import 'package:flipkart/data/cart_data/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {


  CartBloc(this.cartDataService) : super(CartInitial()) {
    on<FetchCartItemsEvent>(fetchCartItemsEvent);
    on<AddToCartItemsEvent>(addToCartItemsEvent);
    on<RemoveFromCartItemsEvent>(removeFromCartItemsEvent);
  }

  CartDataService cartDataService;

  List<Product> cartItems=[];

  FutureOr<void> fetchCartItemsEvent(FetchCartItemsEvent event, Emitter<CartState> emit) {
    cartItems = cartDataService.getCartItems();
    emit(CartLoadedState(cartItems));
  }



  FutureOr<void> addToCartItemsEvent(AddToCartItemsEvent event, Emitter<CartState> emit) {
    cartDataService.addToCart(event.product);
    cartItems = cartDataService.getCartItems();
    emit(AddedToCartState(cartItems));
  }

  FutureOr<void> removeFromCartItemsEvent(RemoveFromCartItemsEvent event, Emitter<CartState> emit) {
    cartDataService.removeFromCart(event.product);
    cartItems = cartDataService.getCartItems();
    emit(RemovedFromCartState(cartItems));
  }

  bool checkIfCartContainsItemEvent(Product product,) {
    return cartDataService.checkIfCartContainsItemEvent(product);
  }

}
