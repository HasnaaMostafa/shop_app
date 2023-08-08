import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/Register/register_screen.dart';
import 'package:shop_app/modules/layout/Home_layout.dart';
import 'package:shop_app/shared/components/BoardingModel.dart';
import 'package:shop_app/shared/components/app_button.dart';
import 'package:shop_app/shared/components/app_textformfield.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';



class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessStates){
            if(state.loginModel?.status==true){
              print(state.loginModel?.data?.token);
              print(state.loginModel?.message);

              CacheHelper.saveData(
                  key: "token", value: state.loginModel?.data?.token).
              then((value)
              {
                token = state.loginModel?.data?.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context)=>const HomeLayout()),
                        (route) => false);
              });

            }
            else{
              print(state.loginModel?.message);
               showToast(
                   message:state.loginModel!.message.toString(),
                   state: ToastStates.error);           }
          }
        },
         builder:(context,state){
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey,
                      child: const Image(
                          image: AssetImage("assets/images/login.png"),
                        width:400,height: 200,alignment: Alignment.topCenter,

                ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 10,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding:EdgeInsets.all(20) ,
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                Text("LOGIN",
                                  style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),),
                                const SizedBox(height: 1,),
                                Text("Login now to browse our hot offers",
                                  style:Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600]
                                  ),),
                                const SizedBox(
                                  height: 20,
                                ),
                                appTextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    label: "Email Address",
                                    hint: "Email",
                                    prefix: Icons.email_outlined,
                                    validate: (String? value){
                                      if(value!.isEmpty){
                                        return "Please enter your email";
                                      }
                                     return null;
                                    },
                                    borderColor: Colors.purple,
                                    prefixColor: Colors.grey,
                                    lColor: Colors.purple,
                                    hColor: Colors.grey,
                                    erorrColor: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                appTextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    label: "Password",
                                    hint: "password",
                                    prefix: Icons.lock_outline,
                                    suffix: ShopLoginCubit.get(context).suffix,
                                    onSubmit: (String? value){
                                      if (formkey.currentState!.validate()){
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    suffixPressed:(){
                                      ShopLoginCubit.get(context).changePasswordVisibility();
                                    },
                                    validate: (String? value){
                                      if(value!.isEmpty){
                                        return "password is too short";
                                      }
                                      return null;
                                    },
                                    isPassword: ShopLoginCubit.get(context).isPassword,
                                    borderColor: Colors.purple,
                                    prefixColor: Colors.grey,
                                    lColor: Colors.purple,
                                    hColor: Colors.grey,
                                    erorrColor: Colors.red),
                                const SizedBox(
                                  height: 35,
                                ),
                                ConditionalBuilder(
                                    condition: state is! ShopLoginLoadingStates,
                                    builder: (context)=>appButton(
                                        text: "login",
                                        function: (){
                                          if (formkey.currentState!.validate()){
                                            cubit.userLogin(
                                                email: emailController.text,
                                                password: passwordController.text);
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
                                        "Don't have an account ?"),
                                    TextButton(
                                        onPressed:(){
                                          Navigator.push
                                            (context,
                                              MaterialPageRoute(builder: (BuildContext context)=>RegisterScreen()));
                                        },
                                        child:const Text("Register now"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
         },

      ),
    );
  }
}


// Scaffold(
//             backgroundColor: Colors.grey,
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       color: Colors.grey,
//                       child: const Image(
//                           image: AssetImage("assets/images/login.png"),
//                         width:400,height: 200,alignment: Alignment.topCenter,
//
//                 ),
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: PhysicalModel(
//                         color: Colors.white,
//                         elevation: 10,
//                         shadowColor: Colors.grey,
//                         borderRadius: BorderRadius.circular(50),
//                         child: Padding(
//                           padding:EdgeInsets.all(20) ,
//                           child: Form(
//                             key: formkey,
//                             child: Column(
//                               children: [
//                                 Text("LOGIN",
//                                   style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),),
//                                 const SizedBox(height: 1,),
//                                 Text("Login now to browse our hot offers",
//                                   style:Theme.of(context).textTheme.bodySmall?.copyWith(
//                                       color: Colors.grey[600]
//                                   ),),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 appTextFormField(
//                                     controller: emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     label: "Email Address",
//                                     hint: "Email",
//                                     prefix: Icons.email_outlined,
//                                     validate: (String? value){
//                                       if(value!.isEmpty){
//                                         return "Please enter your email";
//                                       }
//                                      return null;
//                                     },
//                                     borderColor: Colors.purple,
//                                     prefixColor: Colors.grey,
//                                     lColor: Colors.purple,
//                                     hColor: Colors.grey,
//                                     erorrColor: Colors.red),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 appTextFormField(
//                                     controller: passwordController,
//                                     keyboardType: TextInputType.visiblePassword,
//                                     label: "Password",
//                                     hint: "password",
//                                     prefix: Icons.lock_outline,
//                                     suffix: ShopLoginCubit.get(context).suffix,
//                                     onSubmit: (String? value){
//                                       if (formkey.currentState!.validate()){
//                                         cubit.userLogin(
//                                             email: emailController.text,
//                                             password: passwordController.text);
//                                       }
//                                     },
//                                     suffixPressed:(){
//                                       ShopLoginCubit.get(context).changePasswordVisibility();
//                                     },
//                                     validate: (String? value){
//                                       if(value!.isEmpty){
//                                         return "password is too short";
//                                       }
//                                       return null;
//                                     },
//                                     isPassword: ShopLoginCubit.get(context).isPassword,
//                                     borderColor: Colors.purple,
//                                     prefixColor: Colors.grey,
//                                     lColor: Colors.purple,
//                                     hColor: Colors.grey,
//                                     erorrColor: Colors.red),
//                                 const SizedBox(
//                                   height: 35,
//                                 ),
//                                 ConditionalBuilder(
//                                     condition: state is! ShopLoginLoadingStates,
//                                     builder: (context)=>appButton(
//                                         text: "login",
//                                         function: (){
//                                           if (formkey.currentState!.validate()){
//                                             cubit.userLogin(
//                                                 email: emailController.text,
//                                                 password: passwordController.text);
//                                           }
//                                         },
//                                         background: Colors.purple,
//                                         size: double.infinity,
//                                         textColor: Colors.white),
//                                     fallback: (context)=>
//                                     const Center(child: CircularProgressIndicator())),
//
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                         "Don't have an account ?"),
//                                     TextButton(
//                                         onPressed:(){
//                                           Navigator.push
//                                             (context,
//                                               MaterialPageRoute(builder: (BuildContext context)=>RegisterScreen()));
//                                         },
//                                         child:const Text("Register now"))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//          },
//
//       ),