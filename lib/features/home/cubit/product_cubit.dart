import 'package:bootcamp_task/features/home/cubit/productStates.dart';
import 'package:bootcamp_task/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<Productstates> {
  final Dio dio;
  ProductCubit(this.dio) : super(InitialState()) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request URL: ${options.baseUrl.toString() + options.path.toString()}');
          print('Request headers: ${options.headers.toString()}');
          print('Request data: ${options.data.toString()}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response data: ${response.data.toString()}');
          print('Response headers: ${response.headers.toString()}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('Error: ${e.response.toString()}');
          return handler.next(e);
        },
      ),
    );
  }

  List<ProductModel> products = [];
  Future<void> getAllProducts() async{
    emit(ProductLoadingState());
    try{
    final response= await dio.get('https://dummyjson.com/products');
     if(response.data!=null && response.statusCode==200){
      products=[];
      for(var product in response.data['products']){
        products.add(ProductModel.fromJson(product));
      }
      emit(ProductSuccessState(allProducts: products));
     }
     else{
     emit(ProductErrorState(errorMessage: 'Failed to load products'));

     }
    }
    catch(e,stack){
      print('Stack Trace: $stack');
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }

}