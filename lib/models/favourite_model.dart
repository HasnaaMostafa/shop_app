class FavouriteModel {
  bool? status;
  Data? data;


  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<favouriteData>? data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      json['data'].forEach((element) {
        data?.add(favouriteData.fromJson(element));
      });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }


}

class favouriteData {
  int? id;
  Product? product;

  favouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
