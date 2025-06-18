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
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0),),
              image: const DecorationImage(
                image: AssetImage("assets/resource/default_slide/banner.png"),
                fit: BoxFit.fitWidth,
              ),
            ),

          ),
          SizedBox(height: 16.0,),
          ListTile(
            title: Text("2025智能车实验室讲解演示",style: TextStyle(fontSize: 24.0),),
            subtitle: Text("信息楼B205-207",style: TextStyle(fontSize: 20.0)),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                // mainAxisSpacing: 16.0,
                // crossAxisSpacing: 16.0,
              ),
              padding: const EdgeInsets.only(left: 0,top: 16),
              itemCount: 1,
              itemBuilder: (context, index) {
                return SlideHomeCard(title: "默认展示", description: "默认展示文稿");
              },
            ),
          )


        ],
      ),
    );
  }
}
