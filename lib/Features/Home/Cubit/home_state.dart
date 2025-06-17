part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
 /// Get All products
class GetAllProductsLoadingState extends HomeState {}

class GetAllProductSuccessState extends HomeState {}

class GetAllProductsErrorState extends HomeState {
  final String message;

  GetAllProductsErrorState(this.message);
}
/// Add product
class AddProductLoadingState extends HomeState {}

class AddProductSuccessState extends HomeState {}

class AddProductErrorState extends HomeState {
  final String message;

  AddProductErrorState(this.message);
}
 /// Delete Product
class DeleteProductsLoadingState extends HomeState {}

class DeleteProductSuccessState extends HomeState {}

class DeleteProductsErrorState extends HomeState {
  final String message;

  DeleteProductsErrorState(this.message);
}
/// Search Product
class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {}

class SearchErrorState extends HomeState {
  final String message;

  SearchErrorState(this.message);
}

/// Edit Product

class EditProductLoadingState extends HomeState {}

class EditProductSuccessState extends HomeState {}

class EditProductErrorState extends HomeState {
  final String message;

  EditProductErrorState(this.message);
}