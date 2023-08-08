import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/shared/components/app_button.dart';
import 'package:shop_app/shared/components/components.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (BuildContext context,Object state){},
      builder: (BuildContext context,Object state){
        return Scaffold(
          body: ConditionalBuilder(
              condition: ShopCubit.get(context).getCartModel!=null &&
                  ShopCubit.get(context).getCartModel!.data!.cartItems.isNotEmpty,
              builder: (BuildContext context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: BuildCart(ShopCubit.get(context).getCartModel!,context),
              ),
              fallback: (context)=>Center(child: Image.asset("assets/images/Empty.png")))
        );
      },

    );
  }

  Widget BuildCart(GetCartModel model,context)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Expanded(
        child: Container(
          height: 400,
          child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder:(BuildContext context,int index)=> CartItems(model.data!.cartItems[index],context),
              separatorBuilder: (BuildContext context,int index)=>myDivider(),
              itemCount: model.data!.cartItems.length),

        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text("Totals",
        style:TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ) ,),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text("Sub Total",
          style: TextStyle(
            fontSize: 16
          ),),
          Spacer(),
          Text("${model.data!.sub_total}",
            style: TextStyle(
                fontSize: 16,
              fontWeight: FontWeight.bold
            ),),

        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text("Total",
            style: TextStyle(
                fontSize: 16
            ),),
          Spacer(),
          Text("${model.data!.total}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),

        ],
      ),
      SizedBox(
        height: 20,
      ),
      // Center(
      //   child: appButton(
      //       text: "CheckOut",
      //       background: Colors.purple,
      //       size: 200,
      //       textColor: Colors.white),
      // ),
    ],
  );

  Widget CartItems(CartItem model,context)=>Padding(
    padding:  EdgeInsets.all(10.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Container(
            height: 120,
              width: 120,
            decoration:new BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(model.product!.image!)
              )
            ),

          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(model.product!.name!,
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ) ,
                          maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                      ),
                      Spacer(),
                      Text(
                            "${model.product!.price!} EP",
                        style:TextStyle(
                            fontSize: 16,
                           color: Colors.purple
                        )),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7)
                      ),
                      child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).ChangeToCart(model.product!.id!);
                          },
                          icon:Icon(Icons.delete_outline),
                         color: Colors.black,),
                    )
                  ],
                ),


              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ),
  );
}
