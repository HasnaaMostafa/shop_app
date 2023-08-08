class ChangeCartModel{
  bool? status;
  String? message;
  Data? data;


  ChangeCartModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data=json["data"]!=null?Data.fromJson(json["data"]) : null;
  }


}

class Data{
  int? id;
  int? quantity;
  Product? product;

  Data.fromJson(Map<String,dynamic>json){
    id=json["id"];
    quantity=json["quantity"];
    product=json["product"] !=null ? Product.fromJson(json["product"]) : null;
  }


}


class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String?description;

  Product.fromJson(Map<String,dynamic>json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    description=json["description"];
  }

}