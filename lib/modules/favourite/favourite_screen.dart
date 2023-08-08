import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../layout/cubit_layout/cubit_layout.dart';
import '../product_details/product_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
        listener: (BuildContext context,state){},
        builder: (BuildContext context,state){
          final favouriteList = ShopCubit.get(context).favouriteModel!.data!.data!;
          if(favouriteList.isEmpty)
          {return Center(
              child: Image.asset("assets/images/Empty.png"),
            );}
            return ConditionalBuilder(
              condition: state is ! ShopLoadingGetFavouriteState ,
              builder:(BuildContext context)=>Scaffold(
                backgroundColor: Colors.white,
                appBar:AppBar(
                  centerTitle:true,
                  leading: Icon(
                    Icons.favorite_outline,
                    color: Colors.purple,
                  ),
                  title: Text("Favourites",
                  style: TextStyle(
                    color: Colors.purple
                  ),),
                ) ,
                body: Container(
                  color: Colors.grey[300],
                  clipBehavior: Clip.none,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 15),
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(BuildContext context,int index)=> buildFavProduct(ShopCubit.get(context).favouriteModel!.data!.data![index].product,context),
                        separatorBuilder:(BuildContext context,int index)=>myDivider(),
                        itemCount: ShopCubit.get(context).favouriteModel!.data!.data!.length),
                  ),
                ),
              ) ,
              fallback:(BuildContext context)=> Center(child: CircularProgressIndicator()) ,
            );

        })  ;
  }

  Widget buildFavProduct( model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getProductDetails(model.id);
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
                CachedNetworkImage(imageUrl: model!.image!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (BuildContext context,url)=>const Center(child: CircularProgressIndicator()),),
                if(model.discount != 0)
                  Container(
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
                      Text("${model.price.round()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12,
                          color: Colors.purple,
                          height: 1.4,


                        ),

                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.discount!=0)
                        Text("${model.oldPrice.round()}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10,
                            color: Colors.grey,
                            height: 1.4,
                            decoration: TextDecoration.lineThrough,
                          ),

                        ),
                      const Spacer(),
                      IconButton(
                        icon:  Icon(
                          ShopCubit.get(context).favourites[model.id] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: ShopCubit.get(context).favourites[model.id]== true ? Colors.red : Colors.black,
                        ),
                        onPressed:(){
                          ShopCubit.get(context).changeFavourite(model.id!);
                          print(model.id);
                        },),





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
