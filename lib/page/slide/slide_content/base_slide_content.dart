import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:marquee/marquee.dart';
import 'package:smart_car_lab/class/setting.dart';
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
  SlideConfig slideConfig = SlideConfig();
  int currentPage = 0;
  Data currentSlideData = Data();
  Data nextSlideData = Data();

  Duration _currentTimerTime = Duration.zero;
  StopwatchController stopwatchController = StopwatchController();
  bool _isTimerRunning = false;



  VideoPlayerController? _videoSubController;


  late SubtitleController _subtitleControllerMain;
  late SubtitleController _subtitleControllerSecond;
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Timer? playbackTimer; // 新增计时器控制
  // late VideoPlayerController _videoPlayerController;
  // 示例字幕数据
  bool needDisposeVideoController = false;
  String subtitleContentMain = """
1
00:00:00,000 --> 00:00:03,000
字幕加载错误。请检查字幕文件。

2
00:00:03,000 --> 00:00:06,000
Error srt file.

3
00:00:06,000 --> 00:00:09,000
Lỗi tải phụ đề. Vui lòng kiểm tra tệp phụ đề.

4
00:00:09,000 --> 00:00:12,000
자막 로딩 오류. 자막 파일을 확인해 주세요.

5
00:00:12,000 --> 00:00:15,000
Ошибка загрузки субтитров. Проверьте файл субтитров.

6
00:00:15,000 --> 00:00:18,000
字幕読み込みエラー。字幕ファイルを確認してください。

7
00:00:18,000 --> 00:00:21,000
Erreur de chargement des sous-titres.
""";

  String subtitleContentSecond = """
1
00:00:00,000 --> 00:00:03,000
Error srt file.

2
00:00:03,000 --> 00:00:06,000
Error srt file.

3
00:00:06,000 --> 00:00:09,000
Error srt file.

4
00:00:09,000 --> 00:00:12,000
Error srt file.

5
00:00:12,000 --> 00:00:15,000
Error srt file.

6
00:00:15,000 --> 00:00:18,000
Error srt file.

7
00:00:18,000 --> 00:00:21,000
Error srt file.
""";

  Map<String , String> subtitleMap = {
    'cn 简体中文':"cn",
    'en 英语':"en",
    'vi 越南语':"vi",
    'kr 韩语':"kr",
    'ru 俄语':"ru",
    'ja 日本语':"ja",
    'fr 法语':"fr"
  };

  String firstSrt = "";
  String secondSrt = "";


  @override
  void initState() {
    super.initState();

    stopwatchController.isRunning().then((value) => setState(() => _isTimerRunning = value));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _updateMediaWidth();
      slideConfig =  SlideConfig.fromJson(jsonDecode(await rootBundle.loadString('assets/resource/default_slide/config.json')));

      setState(() {
        firstSrt = subtitleMap[Settings.getValue<String>(Setting.mainSrt,)??"cn"]!;
        secondSrt = subtitleMap[Settings.getValue<String>(Setting.secondSrt,)??"en"]!;
      });
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
      if(needDisposeVideoController){
        _videoSubController?.dispose();
        needDisposeVideoController = false;

      }

      subtitleContentMain = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.${firstSrt}.srt');
      subtitleContentSecond = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.${secondSrt}.srt');
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
      _videoSubController = VideoPlayerController.asset(currentSlideData.media ??"")..initialize().then((_) {
        setState(() {});
      });
      needDisposeVideoController = true;


    }else if(currentSlideData.type == "image"){
      subtitleContentMain = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.${firstSrt}.txt');
      subtitleContentSecond = await rootBundle.loadString('assets/resource/default_slide/${currentSlideData.id}.${secondSrt}.txt');
      setState(() {
        subtitleContentMain;
        subtitleContentSecond;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    /// 图片媒体展示
    Widget imageMedia(String assetPath) => SizedBox(
      // width: 800,
      // height: 600,
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
              if(_videoSubController!=null){
                return videoMedia(_videoSubController!);
              }else{
                return Container();
              }
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
      if(currentPage+1 < slideConfig.data!.length){
        currentPage++;
        _updateSlideData();
      }
    }

    /// 向上翻页幻灯片
    void lastPage() {
      if(currentPage-1 >= 0){
        currentPage--;
        _updateSlideData();
      }
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
              onSelect: () async {

                if(_isTimerRunning){
                  await stopwatchController.pause();
                  setState(() => _isTimerRunning = false);
                }else{
                  await stopwatchController.start();
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
                        SizedBox(width: 1,),
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
      if(_videoSubController!=null){
        return Container(
          child: Column(
            children: [
              SubtitleWrapper(
                  videoPlayerController: _videoSubController!,
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
                  videoPlayerController: _videoSubController!,
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
      }else{
        return Container();
      }
    }

    /// 底部图片字幕
    Widget bottomImgSrt(){
      return Column(
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
                velocity: 40,
                pauseAfterRound: Duration(milliseconds: 0),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
                startPadding: 20.0,
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
                velocity: 40,
                pauseAfterRound: Duration(milliseconds: 0),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
                startPadding: 20.0,
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
                    // mediaContent(),
                    Expanded(child: mediaContent()),
                    sideTipBar,
                    // Expanded(child: sideTipBar),
                    // sideTipBar,
                  ]
              ),
            ),
            bottomSrtBar(),
          ],
        )
    );
  }
}