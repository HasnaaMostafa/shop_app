import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Register/cubit/cubit.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';

import '../../shared/components/BoardingModel.dart';
import '../../shared/components/app_button.dart';
import '../../shared/components/app_textformfield.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../layout/Home_layout.dart';


class RegisterScreen extends StatelessWidget {

  var formkey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phonedController = TextEditingController();

   RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (BuildContext context,Object state){
          if(state is ShopRegisterSuccessStates){
            if(state.registerModel?.status==true){
              print(state.registerModel?.data?.token);
              print(state.registerModel?.message);

              CacheHelper.saveData(
                  key: "token", value: state.registerModel?.data?.token).
              then((value)
              {
                token = state.registerModel?.data?.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context)=>const HomeLayout()),
                        (route) => false);
              });

            }
            else{
              print(state.registerModel?.message);
              showToast(
                  message:state.registerModel!.message.toString(),
                  state: ToastStates.error);           }
          }
        },
        builder: (BuildContext context,Object state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/register.png"),
                          height: 150,alignment: Alignment.topCenter,

                        ),
                        Text("Register",
                          style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),),
                        const SizedBox(height: 1,),
                        Text("Register now to browse our hot offers",
                          style:Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600]
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                        appTextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: "User name",
                            hint:  "User name",
                            prefix: Icons.person,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "Please enter name";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 5,
                        ),
                        appTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email Address",
                            hint: "Email",
                            prefix: Icons.email_outlined,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "Please enter email";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 5,
                        ),

                        appTextFormField(
                            controller: phonedController,
                            keyboardType: TextInputType.phone,
                            label: "Phone",
                            hint: "Phone",
                            prefix: Icons.phone,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "Please enter phone number";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 5,
                        ),
                        appTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            label: "Password",
                            hint: "password",
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            onSubmit: (String? value){
                             
                            },
                            suffixPressed:(){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "please enter password!";
                              }
                              return null;
                            },
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.grey,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                            condition: state is ! ShopRegisterLoadingStates,
                            builder: (context)=>appButton(
                                text: "Register",
                                function: (){
                                  if (formkey.currentState!.validate()){
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phonedController.text);

                                  }
                                },
                                background: Colors.purple,
                                size: double.infinity,
                                textColor: Colors.white),
                            fallback: (context)=>
                            const Center(child: CircularProgressIndicator())),

                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                "Already have an account ?"),
                            TextButton(
                                onPressed:(){
                                  Navigator.push
                                    (context,
                                      MaterialPageRoute(builder: (BuildContext context)=>LoginScreen()));
                                },
                                child:const Text("Login"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
       
      ),
    );
  }
}
