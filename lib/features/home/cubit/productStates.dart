import 'package:bootcamp_task/features/home/data/models/product_model.dart';

abstract class Productstates {}
class InitialState extends Productstates{}
class ProductLoadingState extends Productstates{}
class ProductSuccessState extends Productstates{
  final List<ProductModel> allProducts;
  ProductSuccessState({required this.allProducts});
}
class ProductErrorState extends Productstates{
  final String errorMessage;
  ProductErrorState({required this.errorMessage});
}