import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/shared/components/app_button.dart';
import 'package:shop_app/shared/components/app_textformfield.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var PhoneController=TextEditingController();

  SettingScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(BuildContext context,Object state){},
        builder: (BuildContext context,Object state){
        var model=ShopCubit.get(context).profileModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        PhoneController.text=model.data!.phone!;

        return  ConditionalBuilder(
          condition:ShopCubit.get(context).profileModel !=null ,
          fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()),
          builder:(BuildContext context)=> Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserState)
                        const LinearProgressIndicator(
                          color: Colors.purple,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appTextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: "Name",
                            hint: "Name" ,
                            prefix: Icons.person,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "Name must not be empty";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.purple,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 20,
                        ),
                        appTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email Address",
                            hint: "Email Address" ,
                            prefix: Icons.email_outlined,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "email must not be empty";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.purple,
                            erorrColor: Colors.red),
                        const SizedBox(
                          height: 20,
                        ),
                        appTextFormField(
                            controller: PhoneController,
                            keyboardType: TextInputType.phone,
                            label: "Phone",
                            hint: "Phone" ,
                            prefix: Icons.phone,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return "Phone must not be empty";
                              }
                              return null;
                            },
                            borderColor: Colors.purple,
                            prefixColor: Colors.grey,
                            lColor: Colors.purple,
                            hColor: Colors.purple,
                            erorrColor: Colors.red),

                        const SizedBox(
                          height: 20,
                        ),
                        appButton(
                            function: (){

                              if (formkey.currentState!.validate()){
                                ShopCubit.get(context).updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: PhoneController.text);
                              }
                            },
                            text: "Update",
                            background: Colors.purple,
                            size: double.infinity,
                            textColor: Colors.white),


                        const SizedBox(
                          height: 20,
                        ),
                        appButton(
                          function: (){
                            Signout(context);
                          },
                            text: "Logout",
                            background: Colors.purple,
                            size: double.infinity,
                            textColor: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        }

    );
  }
}
