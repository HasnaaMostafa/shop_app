
import 'package:flutter/material.dart';

class GetCartModel{
  bool? status;
  String? message;
  Data? data;

  GetCartModel.fromJson(Map<String,dynamic>json){
  status=json["status"];
  message=json["message"];
  data=json["data"] !=null ? Data.fromJson(json["data"]) : null;
  }

}

class Data{
  num? sub_total;
  num? total;
  List <CartItem> cartItems=[];

  Data.fromJson(Map<String,dynamic>json){
    sub_total=json["sub_total"];
    total=json["total"];

    json["cart_items"].forEach((element){
      cartItems.add(CartItem.fromJson(element));
    });
  }

}

class CartItem{
  int? id;
  int? quantity;
  Products? product;


  CartItem.fromJson(Map<String,dynamic>json){
    id=json["id"];
    quantity=json["quantity"];

    product=json["product"] !=null ? Products.fromJson(json["product"]): null;
    }

  
}

class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String? description;
  List<String>? images=[];

  Products.fromJson(Map<String, dynamic>json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    description=json["description"];
    json["images"].forEach((element) {
      images?.add(element);
    }
    );
  }
}
