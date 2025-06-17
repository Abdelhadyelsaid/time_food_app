import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_food/Core/Const/AppUrl.dart';
import 'package:time_food/Core/Helper/dio_helper.dart';

import '../Models/products_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  AllProductsModel? allProductsModel;

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoadingState());
    await DioHelper.getData(url: AppUrls.products)
        .then((value) {
          if (value.statusCode == 200) {
            allProductsModel = AllProductsModel.fromJson(value.data);
            print(value.data);
            print("All Products Get Successfully !");
          } else {
            print("All Products get Error !");
            emit(GetAllProductsErrorState("something went wrong"));
          }
          emit(GetAllProductSuccessState());
        })
        .catchError((e) {
          emit(GetAllProductsErrorState(e.toString()));
          print(e.toString());
        });
  }

  Future<void> addProduct({
    required String name,
    required int quantity,
    required String startDate,
    required String endDate,
    required bool sendNotification,
    required File image,
  }) async {
    emit(AddProductLoadingState());
    final formData = FormData.fromMap({
      'name': name,
      'quantity': quantity,
      'startDate': startDate,
      'endDate': endDate,
      'sendNotification': sendNotification ? 'true' : 'false',
      'image': await MultipartFile.fromFile(image.path),
    });

    await DioHelper.postData(
          url: AppUrls.products,
          data: formData,
          isJsonContentType: false,
        )
        .then((value) {
          if (value.statusCode == 200) {
            print(value.data);
            emit(AddProductSuccessState());
            print("Add product Successfully !");
          } else {
            print("add product Error !");
            emit(AddProductErrorState("something went wrong"));
          }
        })
        .catchError((e) {
          emit(AddProductErrorState(e.toString()));
          print(e.toString());
        });
  }

  Future<void> deleteProduct({required String id}) async {
    emit(DeleteProductsLoadingState());
    await DioHelper.deleteData(url: "${AppUrls.products}/$id")
        .then((value) {
          if (value.statusCode == 200) {
            emit(DeleteProductSuccessState());
            print("Deleted Successfully !");
          } else {
            print("Delete Error !");
            emit(DeleteProductsErrorState("something went wrong"));
          }
        })
        .catchError((e) {
          emit(DeleteProductsErrorState(e.toString()));
          print(e.toString());
        });
  }

  Future<void> searchProduct({required String name}) async {
    emit(SearchLoadingState());
    await DioHelper.getData(url: AppUrls.products, query: {"name": name})
        .then((value) {
          if (value.statusCode == 200) {
            allProductsModel = AllProductsModel.fromJson(value.data);
            print(value.data);
            print("Product Get Successfully !");
          } else {
            print("Product get Error !");
            emit(SearchErrorState("something went wrong"));
          }
          emit(SearchSuccessState());
        })
        .catchError((e) {
          emit(SearchErrorState(e.toString()));
          print(e.toString());
        });
  }

  Future<void> editProduct({
    required String id,
    String? name,
    int? quantity,
    String? startDate,
    String? endDate,
    bool? sendNotification,
    File? image,
  }) async {
    emit(EditProductLoadingState());
    final dataMap = <String, dynamic>{};
    if (name != null) dataMap['name'] = name;
    if (quantity != null) dataMap['quantity'] = quantity;
    if (startDate != null) dataMap['startDate'] = startDate;
    if (endDate != null) dataMap['endDate'] = endDate;
    if (sendNotification != null) {
      dataMap['sendNotification'] = sendNotification ? 'true' : 'false';
    }
    if (image != null) {
      dataMap['image'] = await MultipartFile.fromFile(image.path);
    }

    final formData = FormData.fromMap(dataMap);

    try {
      final response = await DioHelper.putData(
        url: '${AppUrls.products}/$id',
        data: formData,
        isJsonContentType: false, // ensure multipart
      );

      if (response.statusCode == 200) {
        print('Edit response: ${response.data}');
        emit(EditProductSuccessState());
        print("Product edited successfully!");
      } else {
        print("Edit product error: ${response.statusCode}");
        emit(EditProductErrorState("Server error: ${response.statusCode}"));
      }
    } catch (e) {
      print("Edit product exception: $e");
      emit(EditProductErrorState(e.toString()));
    }
  }
}
