import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Core/Shared%20Widgets/snackBar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Cubit/recipe_cubit.dart';

class YouTubeListScreen extends StatelessWidget {


  Future<void> _openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الوصفات"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: BlocProvider(
        create: (context) => RecipeCubit()..getAllRecipes(),
        child: BlocConsumer<RecipeCubit, RecipeState>(
          listener: (context, state) {
            if (state is GetAllRecipeErrorState) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            var cubit = RecipeCubit.get(context);
            return state is GetAllRecipeLoadingState ||
                    cubit.allRecipesModel == null
                ? Center(child: CircularProgressIndicator(color: cPrimaryColor))
                : ListView.builder(
                  itemCount: cubit.allRecipesModel?.count,
                  itemBuilder: (context, index) {
                    final item = cubit.allRecipesModel?.recipes[index];
                    return InkWell(
                      onTap: () => _openUrl(item?.url ?? ""),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/youtube.png",
                              width: 40.w,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: .02.sw),
                              child: Text(
                                item?.name ?? "",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                            Image.network(
                              item?.image ?? "",
                              width: 100.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
