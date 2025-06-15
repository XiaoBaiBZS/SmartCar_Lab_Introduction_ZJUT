import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_car_lab/class/srt_parser.dart';
import 'package:smart_car_lab/class/subtitle.dart';
import 'package:smart_car_lab/page/about/about_page.dart';
import 'package:smart_car_lab/page/setting/setting_page.dart';
import 'package:smart_car_lab/page/slide/slide_page.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  int _selectedItemIndex = -1;

  final List<String> _tabTitles = ['介绍', '设置', '关于'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabTitles.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
        _selectedItemIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Smart Car Lab Introduction'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SlidePage(),
          SettingPage(),
          AboutPage(),
        ],
      ),
    );
  }
}