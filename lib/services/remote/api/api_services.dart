

class APIServices{

  Future<List> getProducts() async{
    return Future.delayed(const Duration(seconds: 3), (){
      return ["Manzana", "Mandarina", "Papaya", "Fresa"];
    });
  }

}