import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:smart_car_lab/class/srt_parser.dart';
import 'package:smart_car_lab/class/subtitle.dart';
import 'package:smart_car_lab/widegt/marquee_text.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description:
 *@Version: 1.0
 */

class BaseSlideContent extends StatefulWidget {
  const BaseSlideContent({super.key});

  @override
  State<BaseSlideContent> createState() => _BaseSlideContentState();
}

class _BaseSlideContentState extends State<BaseSlideContent> {
  double? mediaWidth;
  GlobalKey mediaContentGlobalKey = GlobalKey();

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  // 加载并解析SRT文件
  Future<List<Subtitle>> loadSubtitlesFromAssets(String assetsPath) async {
    try {
      final srtContent = await loadAsset(assetsPath);
      return SrtParser.parse(srtContent);
    } catch (e) {
      print('加载或解析字幕时出错: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMediaWidth();
    });
  }

  void _updateMediaWidth() {
    if (mediaContentGlobalKey.currentContext != null) {
      setState(() {
        mediaWidth = mediaContentGlobalKey.currentContext!.size?.width ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 媒体展示组件
    Widget mediaContent = Container(
      key: mediaContentGlobalKey,
      child: Container(
        child: Image.asset("assets/resource/default_slide/0.jpg"),
      ),
    );

    /// 侧边提示栏
    Widget sideTipBar = Container(
      width: 124,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: (){
              },
              focusColor: Theme.of(context).colorScheme.tertiary,
              child:Container(
                child: Container(
                    width: 95,
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        SizedBox(width: 3,),
                        Text("01 : 32",style: TextStyle(fontSize: 22),),
                      ],
                    )
                ),
              )
          ),
          SizedBox(height: 20,),
          Container(
              width: 95,
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,size: 20,color: Theme.of(context).colorScheme.error,),
                  SizedBox(width: 2,),
                  Text("勿踩赛道",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.error),),
                ],
              )
          ),
          Container(
              width: 95,
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,size: 20,color: Theme.of(context).colorScheme.error,),
                  SizedBox(width: 2,),
                  Text("注意安全",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.error),),
                ],
              )
          ),
          SizedBox(height: 20,),

          Expanded(child: Container()),
          Container(
              width: 95,
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.tv,size: 20,color: Theme.of(context).colorScheme.tertiary,),
                  SizedBox(width: 5,),
                  SizedBox(
                    width: 70,
                    height: 28,
                    child:MarqueeText(
                      containerWidth: 70,
                      text: "欢迎页",
                      textStyle:  TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.tertiary),
                      marqueeBuilder: (context, text, textStyle) => Marquee(
                        text: text,
                        style: textStyle,
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 30,
                        pauseAfterRound: Duration(milliseconds: 0),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                        startPadding: 10.0,
                        accelerationDuration: Duration(milliseconds: 100),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 100),
                        decelerationCurve: Curves.easeOut,
                        textDirection: TextDirection.ltr,
                      ),
                      textBuilder: (context, text, textStyle) => Text(
                        text,
                        style: textStyle,
                      ),
                    ),
                  )

                ],
              )
          ),
          Container(
              width: 95,
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.reset_tv,size: 20,color: Theme.of(context).colorScheme.tertiary,),
                  SizedBox(width: 5,),
                  SizedBox(
                    width: 70,
                    height: 28,
                    child:MarqueeText(
                      containerWidth: 70,
                      text: "宣传短片",
                      textStyle:  TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.tertiary),
                      marqueeBuilder: (context, text, textStyle) => Marquee(
                        text: text,
                        style: textStyle,
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 30,
                        pauseAfterRound: Duration(milliseconds: 0),
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.1,
                        fadingEdgeEndFraction: 0.1,
                        startPadding: 10.0,
                        accelerationDuration: Duration(milliseconds: 100),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 100),
                        decelerationCurve: Curves.easeOut,
                        textDirection: TextDirection.ltr,
                      ),
                      textBuilder: (context, text, textStyle) => Text(
                        text,
                        style: textStyle,
                      ),
                    ),
                  )

                ],
              )
          ),
          SizedBox(height: 20,),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: (){
              },
              focusColor: Theme.of(context).colorScheme.tertiary,
              child:Container(
                  width: 95,
                  margin: EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_forward),
                      SizedBox(width: 5,),
                      Text("前进",style: TextStyle(fontSize: 22),),
                    ],
                  )
              )
          ),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: (){
              },
              focusColor: Theme.of(context).colorScheme.tertiary,
              child:Container(
                  width: 95,
                  margin: EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 5,),
                      Text("后退",style: TextStyle(fontSize: 22),),
                    ],
                  )
              )
          ),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: (){
              },
              focusColor: Theme.of(context).colorScheme.tertiary,
              child:Container(
                  width: 95,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.call_received),
                      SizedBox(width: 5,),
                      Text("退出",style: TextStyle(fontSize: 22),),
                    ],
                  )
              ),
          ),
          SizedBox(height: 20,)

        ],
      ),
    );

    /// 底部字幕组件
    Widget bottomSrtBar = Container(
      height: 70,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child:MarqueeText(
              containerWidth: MediaQuery.of(context).size.width,
              text: "欢迎来到浙江工业大学智能车实验室，请大家进入实验室往里边走，赛道四周都可以站。为了保障大家的安全，请不要随意触摸桌子上、货架上的物品，以免发生危险，感谢大家的配合。",
              textStyle:  TextStyle(fontSize: 24,),
              marqueeBuilder: (context, text, textStyle) => Marquee(
                text: text,
                style: textStyle,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
                velocity: 30,
                pauseAfterRound: Duration(milliseconds: 0),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
                startPadding: 10.0,
                accelerationDuration: Duration(milliseconds: 100),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 100),
                decelerationCurve: Curves.easeOut,
                textDirection: TextDirection.ltr,
              ),
              textBuilder: (context, text, textStyle) => Text(
                text,
                style: textStyle,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child:MarqueeText(
              containerWidth: MediaQuery.of(context).size.width,
              text: "Welcome to the Intelligent Vehicle Laboratory of Zhejiang University of Technology. Please proceed inside the laboratory, where you are free to stand around the track. To ensure everyone's safety, please refrain from touching the items on the tables and shelves to avoid any potential hazards. Thank you for your cooperation.",
              textStyle:  TextStyle(fontSize: 22,),
              marqueeBuilder: (context, text, textStyle) => Marquee(
                text: text,
                style: textStyle,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
                velocity: 30,
                pauseAfterRound: Duration(milliseconds: 0),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
                startPadding: 10.0,
                accelerationDuration: Duration(milliseconds: 100),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 100),
                decelerationCurve: Curves.easeOut,
                textDirection: TextDirection.ltr,
              ),
              textBuilder: (context, text, textStyle) => Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ],
      )
    );

    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Row(
                  children: [
                    mediaContent,
                    sideTipBar,
                  ]
              ),
            ),
            bottomSrtBar,
          ],
        )
    );
  }
}