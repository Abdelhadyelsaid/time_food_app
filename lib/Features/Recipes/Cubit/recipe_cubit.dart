import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../Core/Const/AppUrl.dart';
import '../../../Core/Helper/dio_helper.dart';
import '../Model/recipes_model.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());

  static RecipeCubit get(context) => BlocProvider.of(context);

  AllRecipesModel? allRecipesModel;

  Future<void> getAllRecipes() async {
    emit(GetAllRecipeLoadingState());
    await DioHelper.getData(url: AppUrls.getAllrecipes)
        .then((value) {
      if (value.statusCode == 200) {
        allRecipesModel = AllRecipesModel.fromJson(value.data);
        print(value.data);
        print("All Recipes Get Successfully !");
      } else {
        print("All Recipes get Error !");
        emit(GetAllRecipeErrorState("something went wrong"));
      }
      emit(GetAllRecipeSuccessState());
    })
        .catchError((e) {
      emit(GetAllRecipeErrorState(e.toString()));
      print(e.toString());
    });
  }
}
