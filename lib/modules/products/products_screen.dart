
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/category_details/category_details.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/shared/components/BoardingModel.dart';
import '../product_details/product_details_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (BuildContext context,state){
        if(state is ShopSuccessFavouritesDataState){

          if(state.model!.status==false){
            showToast(
                message: state.model!.message!,
                state: ToastStates.error);
          }
        }
      },
      builder: (BuildContext context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homemodel !=null && ShopCubit.get(context).categoriesModel !=null,
            builder: (context)=>productsBuilder(ShopCubit.get(context).homemodel!,ShopCubit.get(context).categoriesModel!,context),
            fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()));
      }
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:

            model.data!.banners.map((e)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: "${e.image}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context ,url)=>const Center(child: CircularProgressIndicator()),

                  ),
                ),
              ),
            ) ).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16/9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            )),
         const SizedBox(
          height: 10,
        ),
         Padding(
           padding: const EdgeInsets.symmetric(
             horizontal: 10,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text("Categories",
               style: TextStyle(
                 color: Colors.purple,
                 fontSize: 24,
                 fontWeight: FontWeight.w600,
               ),),
               const SizedBox(
                 height: 20,
               ),
               Container(
                 color: Colors.grey[300],
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data![index],context),
                      separatorBuilder:(context,index)=>const SizedBox(
                        width: 10,
                      ) ,
                      itemCount: categoriesModel.data!.data!.length),
                ),
        ),
               const SizedBox(
                 height: 20,
               ),
                const Text("New Products",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),),
             ],
           ),
         ),
        const SizedBox(
          height: 20,
        ),
        Container(
          clipBehavior: Clip.none,
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
            child: GridView.count(
              mainAxisSpacing: 30,
                crossAxisSpacing: 15,
                childAspectRatio:1/1.57,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children:
                  List.generate(model.data!.products.length,
                          (index) =>buildGridProduct(model.data!.products[index],context)),

            ),
          ),
        )
      ],),
  );


  Widget buildCategoryItem(DataModel model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getCategoryDetails(model.id!);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context)=>CategoriesDetails()));
    },
    child: Container(
      height: 300,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CachedNetworkImage(imageUrl: model.image!,
            placeholder:(BuildContext context,url)=> const Center(child: CircularProgressIndicator()),
            width: 100,
            height:100,
          fit: BoxFit.cover,),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),),
          )
        ],
      ),
    ),
  );



  Widget buildGridProduct(ProductsModel model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getProductDetails(model.id!);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ProductIn()));
    },
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,

      children: [
        Container(
          height: 300,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.fromLTRB(10, 15, 10, 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topStart,
                children: [

                  GestureDetector(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      child: CachedNetworkImage(
                          imageUrl: model.image!,
                      width: double.infinity,
                      height: 130,
                      placeholder: (BuildContext context,url)=>const Center(child: CircularProgressIndicator()),),
                    ),
                  ),
                  if(model.discount != 0 )
                  Positioned(
                    bottom: 127,
                    right: 97,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name!,
                    maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13,
                    height: 1.2,


                    ),

                      ),
                  Row(
                    children: [
                      Text("${model.price.round()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12,
                          color: Colors.purple,
                          height: 1.2,


                        ),

                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.discount!=0 )
                        Text("${model.oldPrice.round()}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10,
                            color: Colors.grey,
                            height: 1.2,
                            decoration: TextDecoration.lineThrough,
                          ),

                        ),
                      const Spacer(),
                      GestureDetector(
                        child: IconButton(
                            icon: CircleAvatar(
                              radius: 13,
                              backgroundColor: ShopCubit.get(context).favourites[model.id]! ? Colors.purple : Colors.grey,
                              child: Icon(
                                    ShopCubit.get(context).favourites[model.id]! == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 14,
                              ),
                            ),
                             onPressed:(){
                                   ShopCubit.get(context).changeFavourite(model.id!);
                                   print(model.id!);
                             },),
                      ),

                    ],
                  ),
                ],
              ),


            ],
          ),

        ),
        Positioned(
          top:230,
          child: GestureDetector(
            onTap: (){
              ShopCubit.get(context).ChangeToCart(model.id!);
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: ShopCubit.get(context).cart[model.id]! ? Colors.purple : Colors.grey,
              child: Icon(
                ShopCubit.get(context).cart[model.id]! == true
                    ? Icons.shopping_cart_rounded
                    : Icons.shopping_cart_outlined,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
