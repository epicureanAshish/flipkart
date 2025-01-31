part of 'product_bloc.dart';


abstract class ProductEvent {}

class GoToCartEvent extends ProductEvent{}

class LoadProductEvent extends ProductEvent{
  Product product;
  LoadProductEvent(this.product);
}

class AddProductToCartEvent extends ProductEvent{
  Product product;
  AddProductToCartEvent(this.product);
}

class BackToProductFromCartEvent extends ProductEvent{
  Product product;
  BackToProductFromCartEvent(this.product);
}

class ProductCheckIfAddedToCartEvent extends ProductEvent {
  Product product;
  ProductCheckIfAddedToCartEvent(this.product);
}


