import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/categories_details_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favourite_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import '../../../models/login_model.dart';
import '../../../models/search_model.dart';
import '../../../shared/components/components.dart';
import '../../Cart/cart_screen.dart';


class ShopCubit extends Cubit<ShopState>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  IconData? favIcon;
  List<Widget> bottomScreens=[
    const ProductScreen(),
    CategoriesScreen(),
    CartScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  Map<int,bool> favourites={};
  Map<int,bool> cart = {};


  HomeModel? homemodel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: Home,
        token:token).
    then((value){
      homemodel=HomeModel.fromJson(value.data);
      print(homemodel!.status);

      homemodel!.data!.products!.forEach(
              (element) {
                cart.addAll(
                  {
                    element.id! : element.inCart!
                  }
                );
                favourites.addAll(
                {element.id! : element.inFavorites!}
                );
              });
      print(cart.toString());
      print(favourites.toString());

      // printFullText(homemodel!.data!.banners.toString());
      // print(homemodel!.data!.banners[0].image);


      emit(ShopSuccessHomeDataState());

    }).catchError((error){
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategory(){

    DioHelper.getData(url: Categories,).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      emit(ShopErrorCategoriesDataState());
      print(error.toString());
    });
  }

  ChangeFavouritesModel?changeFavouritesModel;
  void changeFavourite(int productId){

    favourites[productId]=!favourites[productId]!;
    emit(ShopChangeFavouritesDataState());

    DioHelper.postData(
        url: Favourites,
        token: token,
        data: {
          "product_id": productId}).then((value){
            changeFavouritesModel=ChangeFavouritesModel.fromJson(value.data);
            print(value.data);

            if(!changeFavouritesModel!.status!){

              favourites[productId]=!favourites[productId]!;
            }else{
              getFavourite();
            }
            emit(ShopSuccessFavouritesDataState(changeFavouritesModel));
    })
        .catchError((error){
         favourites[productId]=!favourites[productId]!;
         emit(ShopErrorFavouritesDataState());
         print(error.toString());
    });
  }


  FavouriteModel? favouriteModel;
  void getFavourite(){
    emit(ShopLoadingGetFavouriteState());
    DioHelper.getData(
        url: Favourites,
        token:token).then((value) {
          favouriteModel=FavouriteModel.fromJson(value.data);
          emit(ShopSuccessGetFavouriteState());
    }).catchError((error){
      emit(ShopErrorGetFavouriteState());
      print(error.toString());
    });
  }


   LoginModel? profileModel;
  void getProfile(){
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
        url:Profile,
        token:token).then((value) {
      profileModel=LoginModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessGetProfileState(profileModel));
    }).catchError((error){
      emit(ShopErrorGetProfileState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  void updateProfile(
  {
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url:UpdateProfile,
        token:token,
        data: {
          "name":name,
          "email":email,
          "phone":phone,
        }).then((value) {
      profileModel=LoginModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessUpdateUserState(profileModel));
    }).catchError((error){
      emit(ShopErrorUpdateUserState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  ChangeCartModel? changeCartModel;
  void ChangeToCart(int productId){
    cart[productId]=!cart[productId]!;
    emit(ShopChangeCartDataState());
    DioHelper.postData(
        url: Cart,
        data: {
          "product_id":productId
        },
        token: token).then((value){
          changeCartModel=ChangeCartModel.fromJson(value.data);

          if(!changeCartModel!.status!){

            cart[productId]=!cart[productId]!;
          }else{
            getCart();
          }
          emit(ShopSuccessChangeCartState(changeCartModel));

    }).catchError((error){
      cart[productId]=!cart[productId]!;
      emit(ShopErrorChangeCartState());
      print(error.toString());
    });
  }


   GetCartModel? getCartModel;
  void getCart(){
       emit(ShopLoadingGetCartState());
    DioHelper.getData(
      url: Cart,
     token: token).then((value) {
      getCartModel=GetCartModel.fromJson(value.data);
      print(getCartModel!.status);
      emit(ShopSuccessGetCartState());
    }).catchError((error){
      emit(ShopErrorGetCartState());
      print(error.toString());
    });
  }


  SearchModel? searchModel;

  void search(String text){
    emit(ShopLoadingSearchStates());
    DioHelper.postData(
        url: Search,
        token: token,
        data: {
          "text":text,
        }).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchStates());

    }).catchError((error){
      emit(ShopErrorSearchStates());
      print(error.toString());
    }
    );
  }


  ProductDetailsModel? productDetailsModel;
  getProductDetails(int ProductId){
    emit(ShopLoadingGetProductDetailsStates());
    DioHelper.getData(
        url: ProductDetails + ProductId.toString(),
        token: token).then((value){
      productDetailsModel=ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsStates());
    }).catchError((error){
      emit(ShopErrorGetProductDetailsStates());
      print(error.toString());
    });
  }

  CategoryDetailsModel? categoryDetailsModel;
  getCategoryDetails(int categoryId){
    emit(ShopLoadingGetCategoryDetailsStates());
    DioHelper.getData(
        url: CategoryDetails + categoryId.toString(),
        token: token).then((value){
      categoryDetailsModel=CategoryDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetCategoryDetailsStates());
    }).catchError((error){
      emit(ShopErrorGetCategoryDetailsStates());
      print(error.toString());
    });
  }



}

