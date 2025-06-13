import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';

class ImageGridScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
    {
      'image': 'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'name': 'Item 1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: .05.sw),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length + 1,
          // Add one for the "plus" container
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            if (index == items.length) {
              // Plus container
              return GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.addProductScreen.name);
                },
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Icon(Icons.add, size: 32, color: Colors.black54),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اضافة',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final item = items[index];
            return InkWell(
              onTap: () {
                context.pushNamed(Routes.productDetailsScreen.name);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['image']!,
                      width: double.infinity,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['name']!,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
