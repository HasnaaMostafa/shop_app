import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/modules/layout/cubit_layout/cubit_layout.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/shared/components/app_button.dart';
import 'package:shop_app/shared/components/constatnts.dart';

class ProductIn extends StatelessWidget {
  const ProductIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, Object state) {
        if (state is ShopSuccessFavouritesDataState) {
          inFavourite = !inFavourite;
        }
        if (state is ShopChangeCartDataState) {
          inCart = !inCart;
        }
      },
      builder: (BuildContext context, Object state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "product",
              style: TextStyle(color: Colors.purple),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetProductDetailsStates,
            builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ProductInItem(
                    ShopCubit.get(context).productDetailsModel!, context)),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget ProductInItem(ProductDetailsModel? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border(
                      bottom: BorderSide(color: Colors.purple, width: 2),
                      top: BorderSide(color: Colors.purple, width: 2),
                      right: BorderSide(color: Colors.purple, width: 2),
                      left: BorderSide(color: Colors.purple, width: 2),
                    )),
                child: CarouselSlider(
                    items: model!.data?.images!
                        .map((e) => CachedNetworkImage(
                              imageUrl: "${e}",
                              width: double.infinity,
                              errorWidget: (BuildContext context, url, error) =>
                                  Icon(Icons.error_outline),
                              placeholder: (BuildContext context, url) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: 200,
                        initialPage: 0,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        viewportFraction: 1)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              model.data?.name! ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Price ${model.data?.price.round() ?? 0}",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            if (model.data!.discount != 0)
              Text(
                "Old Price ${model.data?.oldPrice.round() ?? 0}",
                style: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
            SizedBox(
              height: 20,
            ),
            if (model.data!.discount != 0)
              Text(
                "Discount  ${model.data!.discount}%",
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            SizedBox(
              height: 20,
            ),
            appButton(
                function: () {
                  ShopCubit.get(context).ChangeToCart(model.data?.id! ?? 0);
                },
                text: ShopCubit.get(context).cart[model.data!.id] == true
                    ? "Remove from cart"
                    : "Add to cart",
                background: Colors.purple,
                size: double.infinity,
                textColor: Colors.white),
            SizedBox(
              height: 20,
            ),
            appButton(
                function: () {
                  ShopCubit.get(context).changeFavourite(model.data?.id! ?? 0);
                },
                text: ShopCubit.get(context).favourites[model.data!.id] == true
                    ? "Remove from favourites"
                    : "Add to favourites",
                background: Colors.purple,
                size: double.infinity,
                textColor: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              "Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              model.data?.description! ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
