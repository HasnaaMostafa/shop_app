

import 'package:flutter/material.dart';

class HomeModel {
  bool? status;
  HomeDataModel? data;


  //Named constructor
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data= HomeDataModel.fromJson(json["data"]) ;
  }
}

class HomeDataModel {
  List<BannerModel> banners=[];
  List <ProductsModel> products=[];



  HomeDataModel.fromJson(Map<String,dynamic>json){
   json["banners"].forEach((element){
     banners?.add(BannerModel.fromJson(element));
   });

   json["products"].forEach((element){
     products?.add(ProductsModel.fromJson(element));
   });
  }

}

class BannerModel{
  int? id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic>json){
   id=json["id"];
   image=json["image"];
  }
}

class ProductsModel {
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

  ProductsModel.fromJson(Map<String, dynamic>json){
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
    }
    );
    description=json["description"];
  }
}