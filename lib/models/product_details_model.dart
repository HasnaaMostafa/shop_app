class ProductDetailsModel{
  bool? status;
  ProductDetailsData? data;

  ProductDetailsModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data=ProductDetailsData.fromJson(json["data"]);

  }

}

class ProductDetailsData{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  List<String>? images=[];
  String? description;


  ProductDetailsData.fromJson(Map<String,dynamic>json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"] ;
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    json["images"].forEach((element) {
      images?.add(element);
    });
    description=json["description"];
  }

}