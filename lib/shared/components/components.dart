import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../models/change_cart_model.dart';
import '../../modules/layout/cubit_layout/cubit_layout.dart';
import '../../modules/login/login_screen.dart';
import '../../modules/product_details/product_details_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/web_view/web_view_screen.dart';
import 'constatnts.dart';

Widget BuildArticleItem(article,context)=> InkWell(
      onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(context)=>WebViewScreen(article["url"])));},
  child:Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

        children: [

        Container(

        height: 140,

        width: 140,

        decoration: BoxDecoration(

        borderRadius:

        BorderRadius.circular(10.0,),

        image: DecorationImage(

        image: NetworkImage(

        "${article["image"]}"),

        fit: BoxFit.cover)),),

        const SizedBox(

        width: 20.0,

        ),

        Expanded(

        child: SizedBox(

        height: 140,

        child: Column(

        // mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

        Expanded(

        child: Text("${article["title"]}",

        maxLines: 3,

        overflow: TextOverflow.ellipsis,

        style:

        Theme.of(context).textTheme.bodySmall,),

        ),

        Text("${article["publishedAt"]}",

        style: TextStyle(

        color: Colors.grey,

        ),)

        ],

        ),

        ),

        )

        ],

        ),

        ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 0.1,
    color: Colors.grey[500],
  ),
);

Widget ConditionlBuildArticle(list,context,{isSearch=false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => BuildArticleItem(list[index],context),
      separatorBuilder: (BuildContext context, int index) => myDivider(),
      itemCount: 10,),
      fallback: (context)=>isSearch? Container() : const Center(child: CircularProgressIndicator())
);

void Signout(context){
      CacheHelper.removeData(key:"token").then((value){
            if (value==true){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context)=>LoginScreen()),
                          (route) => false);} }
      );
}

void printFullText(String text){
      final pattern = RegExp(".{1,800}");
      pattern.allMatches(text).forEach((match) {
            print(match.group(0));
      });


}

dynamic token= " ";



// Widget buildFavProduct( model,context, {bool isSearch=false})=>InkWell(
//       onTap: (){
//             ShopCubit.get(context).getProductDetails(model.id);
//                      Navigator.push(context,
//                           MaterialPageRoute(builder: (context)=>ProductIn()));
//
//
//
//
//       },
//   child:   Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SizedBox(
//               height: 120,
//               child: Row(
//                     children: [
//                           Stack(
//                                 alignment: AlignmentDirectional.bottomStart,
//                                 children: [
//                                       CachedNetworkImage(imageUrl: model!.image!,
//                                             width: 120,
//                                             height: 120,
//                                             fit: BoxFit.cover,
//                                             placeholder: (BuildContext context,url)=>const Center(child: CircularProgressIndicator()),),
//                                       if(model.discount != 0 && !isSearch)
//                                             Container(
//                                                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                                                   color: Colors.red,
//                                                   child:const Text(
//                                                         "Discount",style: TextStyle(
//                                                         fontSize: 10,
//                                                         color: Colors.white,
//                                                   ),
//                                                   ),
//                                             ),
//                                 ],
//                           ),
//                           const SizedBox(
//                                 width: 20,
//                           ),
//                           Expanded(
//                                 child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                             Text(model.name!,
//                                                   maxLines: 2,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   style: const TextStyle(fontSize: 13,
//                                                         height: 1.4,
//
//
//                                                   ),
//
//                                             ),
//                                             const Spacer(),
//                                             Row(
//                                                   children: [
//                                                         Text("${model.price.round()}",
//                                                               overflow: TextOverflow.ellipsis,
//                                                               style: const TextStyle(fontSize: 12,
//                                                                     color: Colors.purple,
//                                                                     height: 1.4,
//
//
//                                                               ),
//
//                                                         ),
//                                                         const SizedBox(
//                                                               width: 5,
//                                                         ),
//                                                         if(model.discount!=0 && !isSearch)
//                                                               Text("${model.oldPrice.round()}",
//                                                                     overflow: TextOverflow.ellipsis,
//                                                                     style: const TextStyle(fontSize: 10,
//                                                                           color: Colors.grey,
//                                                                           height: 1.4,
//                                                                           decoration: TextDecoration.lineThrough,
//                                                                     ),
//
//                                                               ),
//                                                         const Spacer(),
//                                                         IconButton(
//                                                               icon:  CircleAvatar(
//                                                                     radius: 15,
//                                                                     backgroundColor: ShopCubit.get(context).favourites[model.id]== true ? Colors.purple : Colors.grey,
//                                                                     child: Icon(
//                                                                           ShopCubit.get(context).favourites[model.id] == true
//                                                                               ? Icons.favorite
//                                                                               : Icons.favorite_border,
//                                                                           size: 14,
//                                                                     ),
//                                                               ),
//                                                               onPressed:(){
//                                                                     ShopCubit.get(context).changeFavourite(model.id!);
//                                                                     print(model.id);
//                                                               },),
//
//
//
//
//
//                                                   ],
//                                             ),
//                                       ],
//                                 ),
//                           ),
//
//
//                     ],
//               ),
//         ),
//   ),
// );










