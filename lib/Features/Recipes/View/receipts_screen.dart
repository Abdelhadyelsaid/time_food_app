import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeListScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'youtubeImage':
      'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=TWpnohR6AoQ&ab_channel=FunKidsEnglish',
    },
    {
      'youtubeImage':
      'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=TWpnohR6AoQ&ab_channel=FunKidsEnglish',
    },
    {
      'youtubeImage':
      'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=TWpnohR6AoQ&ab_channel=FunKidsEnglish',
    },
    {
      'youtubeImage':
      'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=TWpnohR6AoQ&ab_channel=FunKidsEnglish',
    },
  ];

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
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => _openUrl(item['url']!),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    child: Text("لحوم", style: TextStyle(fontSize: 20.sp)),
                  ),
                  Image.network(
                    item['youtubeImage']!,
                    width: 100.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

