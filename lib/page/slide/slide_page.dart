 import 'package:flutter/material.dart';
import 'package:smart_car_lab/widegt/slide/slide_home_card.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

/**
   *@Author: ZhanshuoBai
   *@CreateTime: 2025-06-14
   *@Description:
   *@Version: 1.0
   */

class SlidePage extends StatefulWidget {
  const SlidePage({super.key});

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      itemCount: 1,
      itemBuilder: (context, index) {
        return SlideHomeCard(title: "默认展示", description: "默认展示文稿");
      },
    );
  }
}
