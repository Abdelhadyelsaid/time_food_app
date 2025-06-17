part of 'recipe_cubit.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}


class GetAllRecipeLoadingState extends RecipeState {}

class GetAllRecipeSuccessState extends RecipeState {}

class GetAllRecipeErrorState extends RecipeState {
  final String message;

  GetAllRecipeErrorState(this.message);
}