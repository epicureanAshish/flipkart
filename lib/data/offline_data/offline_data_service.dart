
import 'package:flutter/services.dart';

class OfflineDataService{

  OfflineDataService();

  Future fetchProducts()async{
    return await rootBundle.loadString("assets/products/products_data.json");
  }

}