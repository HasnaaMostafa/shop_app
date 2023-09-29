import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubits/AppStates.dart';
import 'package:shop_app/shared/cubits/Appcubit.dart';
import 'package:shop_app/shared/cubits/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/theme.dart';
import 'modules/layout/Home_layout.dart';
import 'modules/layout/cubit_layout/cubit_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key: "isDark");
  Widget widget;
  bool? onBoarding=CacheHelper.getData(key:"OnBoarding");
  token=CacheHelper.getData(key:"token");
  print(token);

  //hasnaa
  //hello

  if(onBoarding !=null) {
    if(token != null){
        widget=const HomeLayout();
      }
      else{
        widget=LoginScreen();
      }
    }
    else{
    widget=const OnBoardingScreen();
  }
  runApp(MyApp(
       isDark:isDark,
      startWidget: widget));
  }

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  const MyApp({super.key, this.isDark,this.startWidget});
 //hello

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (BuildContext context)=> AppCubit()..changeAppMode(
          fromShared: isDark,
        ),),
        BlocProvider(create:(BuildContext context) => ShopCubit()..getHomeData()..getCategory()..getFavourite()..getProfile()..getCart(),),

      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates states){},
        builder: (BuildContext context,AppStates states){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isnotDark ? ThemeMode.light : ThemeMode.dark,
            home: OnBoardingScreen(),
          );
        }
      ),
    );
  }
}



