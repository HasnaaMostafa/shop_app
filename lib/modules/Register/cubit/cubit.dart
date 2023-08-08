import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points/end_points.dart';

class ShopRegisterCubit extends Cubit <ShopRegisterStates>{
  ShopRegisterCubit(): super(ShopRegisterInitialStates());

  LoginModel? registerModel;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone})
  {

    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: Register,
        data:{
          "email": email,
          "password": password,
          "name":name,
          "phone":phone
        },).then((value) {
         // RegisterModel = RegisterModel.fromJson(value.data);
          print(value.data);
          registerModel=LoginModel.fromJson(value.data);
          print((registerModel?.data?.token));
          emit(ShopRegisterSuccessStates(registerModel));
    }).catchError((error){
          print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =isPassword ?Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordVisibilityStates());
  }

}