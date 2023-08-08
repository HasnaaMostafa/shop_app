import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favourite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopState{}

class ShopInitialState extends ShopState{}

class ShopSuccessHomeDataState extends ShopState{}

class ShopLoadingHomeDataState extends ShopState{}

class ShopErrorHomeDataState extends ShopState{}

class ShopChangeBottomNavState extends ShopState{}

class ShopSuccessCategoriesDataState extends ShopState{}

class ShopErrorCategoriesDataState extends ShopState{}

class ShopSuccessFavouritesDataState extends ShopState{

  ChangeFavouritesModel? model;

  ShopSuccessFavouritesDataState(this.model);

}

class ShopChangeFavouritesDataState extends ShopState{}

class ShopErrorFavouritesDataState extends ShopState{}

class ShopLoadingGetFavouriteState extends ShopState{}

class ShopSuccessGetFavouriteState extends ShopState{}

class ShopErrorGetFavouriteState extends ShopState{}


class ShopLoadingGetProfileState extends ShopState{}

class ShopSuccessGetProfileState extends ShopState{
  LoginModel? loginModel;

  ShopSuccessGetProfileState(this.loginModel);
}


class ShopErrorGetProfileState extends ShopState{}

class ShopLoadingUpdateUserState extends ShopState{}

class ShopSuccessUpdateUserState extends ShopState{
  LoginModel? loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}


class ShopErrorUpdateUserState extends ShopState{}


class ShopLoadingGetCartState extends ShopState{}

class ShopSuccessGetCartState extends ShopState{}

class ShopErrorGetCartState extends ShopState{}

class ShopChangeCartDataState extends ShopState{}

class ShopSuccessChangeCartState extends ShopState{
  ChangeCartModel? changeCartModel;

  ShopSuccessChangeCartState(this.changeCartModel);
}

class ShopErrorChangeCartState extends ShopState{}


class ShopLoadingSearchStates extends ShopState{}

class ShopSuccessSearchStates extends ShopState{}

class ShopErrorSearchStates extends ShopState{}


class ShopLoadingGetProductDetailsStates extends ShopState{}

class ShopSuccessGetProductDetailsStates extends ShopState{}

class ShopErrorGetProductDetailsStates extends ShopState{}


class ShopLoadingGetCategoryDetailsStates extends ShopState{}

class ShopSuccessGetCategoryDetailsStates extends ShopState{}

class ShopErrorGetCategoryDetailsStates extends ShopState{}








