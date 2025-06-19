import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_car_lab/class/srt_parser.dart';
import 'package:smart_car_lab/class/subtitle.dart';
import 'package:smart_car_lab/page/about/about_page.dart';
import 'package:smart_car_lab/page/setting/setting_page.dart';
import 'package:smart_car_lab/page/slide/slide_page.dart';
import 'package:smart_car_lab/widegt/slide/slide_home_card.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<String> _tabTitles = ['演示文稿', '应用设置', '关于应用'];
  final List<IconData> _tabTitlesIcons = [Icons.panorama_horizontal, Icons.settings_outlined, Icons.info_outline];

  // 定义侧边栏宽度
  final double _sidebarWidth = 200;

  // 存储页面内容
  final List<Widget> _pages = const [
    SlidePage(),
    SettingPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧侧边栏
          Container(
            width: _sidebarWidth,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                // 侧边栏标题
                Container(
                  padding: const EdgeInsets.only(left: 14.0,right: 20,top: 32,bottom: 32),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        width: _sidebarWidth-34,
                        child: Image.asset("assets/icon/textlogo.png"),
                      ),
                      // const Text(
                      //   'LabNav',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  )
                ),


                // 侧边栏菜单项
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 4.0,bottom: 4,),

                    child:  ListView.builder(
                      itemCount: _tabTitles.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _currentIndex;
                        return Container(
                          margin: const EdgeInsets.only(left: 6.0,right: 8,),
                          child:  TVFocusWidget(
                              focusColor: Theme.of(context).colorScheme.primary ,
                              onSelect: (){
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Icon(_tabTitlesIcons[index]),
                                    SizedBox(width: 8.0),
                                    Text(
                                      _tabTitles[index],
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.white70,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                selected: isSelected,
                                selectedTileColor: Colors.white10,
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              )
                          ),
                        );
                      },
                    ),
                  )
                ),
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.only(left: 16.0,right: 16,top: 32,bottom: 32),
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: _sidebarWidth-32,
                    child: Image.asset("assets/icon/labtextlogo.png"),
                  ),
                ),
              ],
            ),
          ),

          // 右侧内容区域
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }
}