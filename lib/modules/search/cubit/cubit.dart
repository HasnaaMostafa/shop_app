// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/models/search_model.dart';
// import 'package:shop_app/modules/search/cubit/states.dart';
// import 'package:shop_app/shared/components/components.dart';
// import 'package:shop_app/shared/network/end_points/end_points.dart';
// import 'package:shop_app/shared/network/remote/dio_helper.dart';
//
// class SearchCubit extends Cubit<SearchStates>{
//
//   SearchCubit():super(ShopInitialSearchStates());
//
//   static SearchCubit get(context)=>BlocProvider.of(context);
//
//   SearchModel? searchModel;
//
//   void search(String text){
//     emit(ShopLoadingSearchStates());
//     DioHelper.postData(
//         url: Search,
//         token: token,
//         data: {
//           "text":text,
//         }).then((value){
//           searchModel=SearchModel.fromJson(value.data);
//           emit(ShopSuccessSearchStates());
//
//     }).catchError((error){
//       emit(ShopErrorSearchStates());
//       print(error.toString());
//     }
//     );
//   }
//
//
// }