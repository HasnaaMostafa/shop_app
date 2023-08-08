import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/category_details/category_details.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import '../layout/cubit_layout/states_layout.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(BuildContext context,state){},
      builder:(BuildContext context,state){
        return Container(
          color: Colors.grey[300],
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context,int index)=>buildCategoriesItems(ShopCubit.get(context).categoriesModel!.data!.data![index],context),
                separatorBuilder:(BuildContext context,int index)=> myDivider(),
                itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length),
          ),
        );
      } ,
    );

  }
  Widget buildCategoriesItems(DataModel? model,context)=> InkWell(
    onTap: (){
      ShopCubit.get(context).getCategoryDetails(model.id!);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context)=> CategoriesDetails()));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.fromLTRB(15, 15, 10, 20),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,),
        child: Row(
          children: [
            CachedNetworkImage(imageUrl: model!.image!,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            placeholder: (BuildContext context,url)=>const Center(child: CircularProgressIndicator()),),
            // Image(
            //   image:
            //   NetworkImage(model!.image!),
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(
              width: 20,
            ),
            Text((model.name!),
              style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ) ,),
            const Spacer(),
            const Icon(
                Icons.arrow_forward_ios)
          ],
        ),
      ),
    ),
  );
}
