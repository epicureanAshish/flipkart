
import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:hive/hive.dart';

class CartDataService{
  CartDataService();

  final Box<Product> cartBox = Hive.box<Product>('cartBox');

  List<Product> getCartItems(){
    return cartBox.values.toList();
  }

  void addToCart(Product product){
    if(cartBox.containsKey(product.id)){
      final item = cartBox.get(product.id)!;
      item.quantityAvailable=item.quantityAvailable!+1;
      cartBox.put(product.id, item);
    }else{
      cartBox.put(product.id, product);
    }
  }

  void removeFromCart(Product product){
    cartBox.delete(product.id);
  }

  bool checkIfCartContainsItemEvent(Product product){
    return cartBox.containsKey(product.id);
  }
}