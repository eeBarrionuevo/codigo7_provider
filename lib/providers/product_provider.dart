

import 'package:codigo7_provider/services/remote/api/api_services.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{

  APIServices apiServices = APIServices();

  Future<List> getProducts() async {
    return await apiServices.getProducts();
  }

}