import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Cart/cart_screen.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/layout/cubit_layout/states_layout.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'cubit_layout/cubit_layout.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(BuildContext context,state){},
      builder: (BuildContext context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Boutique",
              style:TextStyle(color: Colors.purple) ,),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>SearchScreen()));
              },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          drawer: Drawer(
            backgroundColor: Colors.white.withOpacity(.01),
            child: Column(
              children: [
                if(cubit.profileModel!=null)
                Container(
                  color: Colors.purple,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                    ),
                    currentAccountPicture:Image(
                      image: NetworkImage(ShopCubit.get(context).profileModel!.data!.image!),
                    ) ,
                    accountName: Text(ShopCubit.get(context).profileModel!.data!.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    accountEmail: Text(
                        ShopCubit.get(context).profileModel!.data!.email!,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading:Icon(
                            Icons.home,
                            color: Colors.purple,
                          ) ,
                          title: Text(
                            "Home",
                            style: TextStyle(
                              color: Colors.purple
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>HomeLayout()));
                          },
                        ),
                        ListTile(
                          leading:Icon(
                            Icons.favorite,
                            color: Colors.purple,
                          ) ,
                          title: Text(
                            "Favourites",
                            style: TextStyle(
                                color: Colors.purple
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>FavouriteScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index ){
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),


            ],

          ),
        );
      },
    );
  }
}
