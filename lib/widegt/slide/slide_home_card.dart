import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_car_lab/class/srt_parser.dart';
import 'package:smart_car_lab/class/subtitle.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description:
 *@Version: 1.0
 */

class SlideHomeCard extends StatefulWidget {

  SlideHomeCard({super.key,required this.title,required this.description,});

  String title = '默认展示';
  String description = '默认展示文稿';
  bool isSelected = false;

  @override
  State<SlideHomeCard> createState() => _SlideHomeCardState();
}

class _SlideHomeCardState extends State<SlideHomeCard> {
  @override
  Widget build(BuildContext context) {
    return TVFocusWidget(
      onFocus: () => print('获得焦点'),
      onBlur: () => print('失去焦点'),
      onSelect: () async {

        Future<String> loadAsset(String path) async {
          return await rootBundle.loadString(path);
        }

        // 加载并解析SRT文件
        Future<List<Subtitle>> loadSubtitlesFromAssets() async {
          try {
            final srtContent = await loadAsset('assets/resource/default_slide/1.en.srt');
            return SrtParser.parse(srtContent);
          } catch (e) {
            print('加载或解析字幕时出错: $e');
            return [];
          }
        }

        // 假设在应用文档目录下有一个名为 subtitles.srt 的文件
        final subtitles = await loadSubtitlesFromAssets();

        // 打印解析结果
        for (final subtitle in subtitles) {
          print(subtitle);
        }
      },
      focusColor: widget.isSelected ?  Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: widget.isSelected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2.0) : null,
        ),
        child: Card(
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                color: widget.isSelected ? Colors.green : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
