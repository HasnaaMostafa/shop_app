import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_details_model.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';

import '../../shared/components/constatnts.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (BuildContext context,Object state) {
        if (state is ShopSuccessFavouritesDataState) {
          inFavourite = !inFavourite;
        }
        if (state is ShopChangeCartDataState) {
          inCart = !inCart;
        }
      },
      builder: (BuildContext context,Object state){
        var model=ShopCubit.get(context).categoryDetailsModel!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition:state is ! ShopLoadingGetCategoryDetailsStates ,
            builder: (BuildContext context)=> Container(
              color: Colors.grey[300],
              clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GridView.count(
                      crossAxisCount: 2,
                  childAspectRatio: 1/1.9,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children:
                    List.generate(model!.catData.length,
                            (index) =>CategoryProduct(model.catData[index], context) )
                  ,),
                ),
              ),
            ) ,
            fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },

    );
  }

  Widget CategoryProduct(CatData? model,context)=>Padding(
    padding: const EdgeInsets.all(7.0),
    child: Container(
      height: 300,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.fromLTRB(10, 15, 10, 25),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              InkWell(
                onTap: (){
                  ShopCubit.get(context).getProductDetails(model.id!);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=>ProductIn()));
                },
                child: CachedNetworkImage(imageUrl: model!.image!,
                errorWidget: (BuildContext context,String url , dynamic error)=>
                  Icon(Icons.error_outline),
                  width: double.infinity,
                  height: 130,),
              ),
              if(model.discount!=0)
                Positioned(
                bottom: 110,
                right: 88,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child:const Text(
                    "Discount",style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
            ],
          ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),

                ),
                Row(
                  children: [
                    Text("${model.price.round()}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.purple
                    ),),
                    SizedBox(
                      width: 3,
                    ),
                    if(model.discount!=0)
                      Text("${model.oldPrice.round()}",
                        style: TextStyle(
                            fontSize: 6,
                            color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),),
                       Spacer(),],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        ShopCubit.get(context).favourites[model.id] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: ShopCubit.get(context).favourites[model.id]==true? Colors.red : Colors.black,
                      ),
                      onPressed:(){
                        ShopCubit.get(context).changeFavourite(model.id!);
                        print(model.id!.toString());
                      },),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).ChangeToCart(model.id!);
                          print(model.id!.toString());
                        },
                        icon: Icon(
                          ShopCubit.get(context).cart[model.id] == true
                              ? Icons.shopping_cart_rounded
                              : Icons.shopping_cart_outlined,
                          size: 20,


                        )),

                  ],
                )
              ],
            )

        ],
      ),

    ),
  );
}
