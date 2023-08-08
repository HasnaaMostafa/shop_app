import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import '../../../models/login_model.dart';

class ShopLoginCubit extends Cubit <ShopLoginStates>{
  ShopLoginCubit(): super(ShopLoginInitialStates());

  LoginModel? loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  

  void userLogin({
    required String email,
    required String password,})
  {

    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: LOGIN,
        data:{
          "email": email,
          "password": password,
        },).then((value) {
         // loginModel = LoginModel.fromJson(value.data);
          print(value.data);
          loginModel=LoginModel.fromJson(value.data);
          print((loginModel?.data?.token));
          emit(ShopLoginSuccessStates(loginModel));
    }).catchError((error){
          print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =isPassword ?Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilityStates());
  }

}