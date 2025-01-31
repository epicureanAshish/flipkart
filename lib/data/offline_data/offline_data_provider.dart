
import 'dart:convert';

import 'package:flipkart/data/offline_data/offline_data_service.dart';
import 'package:flutter/material.dart';

class OfflineDataProvider{
  final OfflineDataService offlineDataService;
  OfflineDataProvider(this.offlineDataService){
    products();
  }

  List productsData=[];

  Future products()async{
    var data= await offlineDataService.fetchProducts();
    debugPrint("Products: ${jsonDecode(data)}");
    productsData= jsonDecode(data);
  }

}