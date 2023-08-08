
import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
   LoginModel? registerModel;
  ShopRegisterSuccessStates(this.registerModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorStates(this.error) ;
}

class ShopRegisterChangePasswordVisibilityStates extends ShopRegisterStates {}
