import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/app_textformfield.dart';
import '../../shared/components/components.dart';
import '../layout/cubit_layout/cubit_layout.dart';
import '../layout/cubit_layout/states_layout.dart';
import '../product_details/product_details_screen.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var settingController=TextEditingController();
   SearchScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (BuildContext context,Object state){},
      builder:  (BuildContext context,Object state){
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  appTextFormField(
                      controller: settingController,
                      keyboardType: TextInputType.text,
                      label: "Search",
                      hint: "Search",
                      prefix: Icons.search,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return "Please enter something to search!";
                        }
                        return null;
                      },
                      onSubmit: (String? text){
                        ShopCubit.get(context).search(text!);
                      },
                      borderColor: Colors.purple,
                      prefixColor: Colors.grey,
                      lColor: Colors.purple,
                      hColor: Colors.grey,
                      erorrColor: Colors.red),
                  const SizedBox(
                    height: 10,
                  ),
                  if(state is ShopLoadingSearchStates)
                  const LinearProgressIndicator(
                    color: Colors.purple,
                  ),
                 if (state is ShopSuccessSearchStates)
                  Expanded(
                    child: Container(
                      color: Colors.grey[300],
                      clipBehavior: Clip.none,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder:(BuildContext context,int index)=> buildSearchProduct(ShopCubit.get(context).searchModel!.data!.data[index],context),
                          separatorBuilder:(BuildContext context,int index)=>myDivider(),
                          itemCount: ShopCubit.get(context).searchModel!.data!.data.length),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buildSearchProduct(Product model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getProductDetails(model.id!);

      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ProductIn()));
    },
    child:   Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
           height: 130,
           clipBehavior: Clip.hardEdge,
           padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(imageUrl: model.image!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (BuildContext context,url)=>const Center(child: CircularProgressIndicator()),),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13,
                      height: 1.4,


                    ),

                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(model.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12,
                          color: Colors.purple,
                          height: 1.4,
                        ),

                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    ),
  );
}
