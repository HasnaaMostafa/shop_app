class CategoryDetailsModel{
  bool? status;
  CategoriesDetailsData? data;

  CategoryDetailsModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data=CategoriesDetailsData.fromJson(json["data"]);
  }
}

class CategoriesDetailsData{
  int? currentPage;
  List<CatData> catData=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  CategoriesDetailsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      catData.add(CatData.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];}
}

class CatData{
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

  CatData.fromJson(Map<String, dynamic> json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"] ;
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    // json["images"].forEach((element) {
    //   images?.add(element);
    // });
    images=json["images"].cast<String>();
    description=json["description"];
  }
}