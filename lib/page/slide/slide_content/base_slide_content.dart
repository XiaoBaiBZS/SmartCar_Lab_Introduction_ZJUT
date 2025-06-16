import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:smart_car_lab/class/slide_config.dart';

import 'package:smart_car_lab/widegt/marquee_text.dart';
import 'package:smart_car_lab/widegt/slide/timer.dart';
import 'package:smart_car_lab/widegt/slide/video.dart';


import 'package:smart_car_lab/widegt/tv_focus_widget.dart';
import 'package:subtitle_wrapper_package/data/data.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper.dart';


import 'package:video_player/video_player.dart';

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
  // double? mediaWidth;
  // GlobalKey mediaContentGlobalKey = GlobalKey();

  SlideConfig slideConfig = SlideConfig();
  int currentPage = 0;
  Data currentSlideData = Data();
  Data nextSlideData = Data();



  Duration _currentTimerTime = Duration.zero;
  StopwatchController stopwatchController = StopwatchController();
  bool _isTimerRunning = false;



  late VideoPlayerController _videoSubController;


  late SubtitleController _subtitleControllerMain;
  late SubtitleController _subtitleControllerSecond;
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Timer? playbackTimer; // 新增计时器控制
  // late VideoPlayerController _videoPlayerController;
  // 示例字幕数据
  String subtitleContentMain = """
1
00:00:00,000 --> 00:00:03,000
这是第一句字幕，显示3秒钟。


2
00:00:03,000 --> 00:00:06,000
第二句字幕在3秒后出现，持续3秒。

3
00:00:06,000 --> 00:00:09,000
第三句字幕展示一些不同的内容。

4
00:00:09,000 --> 00:00:12,000
最后一句字幕，之后会重新开始。
""";

  String subtitleContentSecond = """
1
00:00:00,000 --> 00:00:03,000
这是第一句字幕，显示3秒钟。


2
00:00:03,000 --> 00:00:06,000
第二句字幕在3秒后出现，持续3秒。

3
00:00:06,000 --> 00:00:09,000
第三句字幕展示一些不同的内容。

4
00:00:09,000 --> 00:00:12,000
最后一句字幕，之后会重新开始。
""";


  @override
  void initState() {
    super.initState();

    stopwatchController.isRunning().then((value) => setState(() => _isTimerRunning = value));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _updateMediaWidth();
      slideConfig =  SlideConfig.fromJson(jsonDecode(await rootBundle.loadString('assets/resource/default_slide/config.json')));
      _updateSlideData();

    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  Future<void> _updateSlideData() async {


    setState(() {
      slideConfig;
      currentSlideData = slideConfig.data![currentPage];
      if(currentPage+1 >= slideConfig.data!.length){
        nextSlideData = Data();
      }else{
        nextSlideData = slideConfig.data![currentPage+1];
      }
    });

    if(currentSlideData.type == "video"){

      subtitleContentMain = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.cn.srt');
      subtitleContentSecond = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.en.srt');
      // 初始化字幕控制器
      _subtitleControllerMain = SubtitleController(
        subtitleType: SubtitleType.srt,
        subtitlesContent: subtitleContentMain,

      );
      _subtitleControllerSecond = SubtitleController(
        subtitleType: SubtitleType.srt,
        subtitlesContent: subtitleContentSecond,

      );
      // 初始化视频控制器 (这里使用网络视频示例)
      _videoSubController = VideoPlayerController.asset(currentSlideData.media  ??"")..initialize().then((_) {
        setState(() {});
      });
    }else if(currentSlideData.type == "image"){
      subtitleContentMain = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.cn.txt');
      subtitleContentSecond = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.en.txt');
      setState(() {
        subtitleContentMain;
        subtitleContentSecond;
      });
    }
  }

  // void _updateMediaWidth() {
  //   if (mediaContentGlobalKey.currentContext != null) {
  //     setState(() {
  //       mediaWidth = mediaContentGlobalKey.currentContext!.size?.width ?? 0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    /// 图片媒体展示
    Widget imageMedia(String assetPath) => SizedBox(
      width: 800,
      height: 600,
      child: Image.asset(assetPath),
    );

    /// 视频媒体展示
    Widget videoMedia(VideoPlayerController videoSubController) => SizedBox(
      width: 800,
      height: 600,
      child: VideoPlayerComponent(
        videoController: videoSubController,
      ),
    );

    /// 媒体展示组件
    Widget mediaContent(){
      return Container(
        // key: mediaContentGlobalKey,
        child: Builder(
          builder: (context) {
            if (currentSlideData.type == "image") {
              return imageMedia(currentSlideData.media ?? "");
            } else {
              // 只有需要显示视频时才会评估这个分支
              return videoMedia(_videoSubController);
            }
          },
        ),
      );
    }


    /// 侧边提示信息
    Widget warningTip(String content) => Container(
        width: 95,
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded,size: 20,color: Theme.of(context).colorScheme.error,),
            SizedBox(width: 2,),
            Text(content,style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.error),),
          ],
        )
    );

    /// 侧边当前页主题
    Widget currentPageTitle = Container(
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
                text: currentSlideData.title??"当前页",
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
    );

    /// 侧边下一页主题
    Widget nextPageTitle = Container(
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
                text: nextSlideData.title??"讲解结束",
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
    );

    /// 向下翻页幻灯片
    void nextPage() {
      currentPage++;
      _updateSlideData();
    }

    /// 向上翻页幻灯片
    void lastPage() {
      currentPage--;
      _updateSlideData();
    }

    /// 退出放映
    void exit() {
      Navigator.of(context).pop();
    }

    /// 侧边提示栏
    Widget sideTipBar = Container(
      width: 124,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: () async {

                if(_isTimerRunning){
                  await stopwatchController.pause();
                  print(_isTimerRunning);
                  setState(() => _isTimerRunning = false);
                }else{
                  await stopwatchController.start();
                  print(_isTimerRunning);
                  setState(() => _isTimerRunning = true);
                }

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
                        StopwatchWidget(
                          onTimeChanged: (duration) {
                            setState(() {
                              _currentTimerTime = duration;
                            });
                          },
                          showButtons: false,
                          controller: stopwatchController,
                          timeTextStyle: const TextStyle(
                            fontSize: 22,
                          ),
                          buttonTextStyle: const TextStyle(fontSize: 18),
                          updateInterval: const Duration(milliseconds: 100),
                        ),
                      ],
                    )
                ),
              )
          ),
          SizedBox(height: 20,),
          warningTip("勿踩赛道"),
          warningTip("注意安全"),
          SizedBox(height: 20,),
          Expanded(child: Container()),
          currentPageTitle,
          nextPageTitle,
          SizedBox(height: 20,),
          TVFocusWidget(
              onFocus: () => print('获得焦点'),
              onBlur: () => print('失去焦点'),
              onSelect: (){
                nextPage();
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
                lastPage();
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
                exit();
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


    /// 底部视频字幕
    Widget bottomSrt(){
      return Container(
        child: Column(
          children: [
            SubtitleWrapper(
                videoPlayerController: _videoSubController,
                subtitleController: _subtitleControllerMain,
                subtitleStyle: const SubtitleStyle(
                  textColor: Colors.white,
                  fontSize: 28,
                  position: SubtitlePosition(bottom: 0,),

                ), videoChild:Container(
              height: 35,
            ) // 视频播放器部分

            ),
            SubtitleWrapper(
                videoPlayerController: _videoSubController,
                subtitleController: _subtitleControllerSecond,
                subtitleStyle: const SubtitleStyle(
                  textColor: Colors.white,
                  fontSize: 28,
                  position: SubtitlePosition(bottom: 0,),
                ), videoChild:Container(
              height: 35,
            ) // 视频播放器部分

            ),
          ],
        ),
      );
    }

    /// 底部图片字幕
    Widget bottomImgSrt(){

      return       Column(
        children: [

          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child:MarqueeText(
              containerWidth: MediaQuery.of(context).size.width,
              text: subtitleContentMain,
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
              text: subtitleContentSecond,
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
      );
    }

    /// 底部字幕组件
    Widget bottomSrtBar() {
      return Container(
        height: 70,
        child: Builder(
          builder: (context) {
            if (currentSlideData.type == "image") {
              return bottomImgSrt();
            } else {
              return bottomSrt();
            }
          },
        ),
      );
    }


    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Row(
                  children: [
                    mediaContent(),
                    sideTipBar,
                  ]
              ),
            ),
            bottomSrtBar(),
          ],
        )
    );
  }
}