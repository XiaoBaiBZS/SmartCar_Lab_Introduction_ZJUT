import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_lab/route/route_utils.dart';
import 'package:smart_car_lab/route/routes.dart';
import 'package:smart_car_lab/widegt/slide/slide_home_card.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description: 可滚动的幻灯片页面
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
    return SafeArea(
      child: SingleChildScrollView(
        // 添加滚动控制器（可选，用于自定义滚动行为）
        // controller: _scrollController,
        physics: const ClampingScrollPhysics(), // 防止滚动到边界时的弹跳效果
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                ),
                image: const DecorationImage(
                  image: AssetImage("assets/resource/default_slide/banner.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ListTile(
                  title: Text(
                    "2025智能车实验室讲解演示",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  subtitle: Text("信息楼B205-207", style: TextStyle(fontSize: 20.0)),
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  TVFocusWidget(
                    focusColor: Theme.of(context).colorScheme.primary,
                    onSelect: () {
                      RouteUtils.pushForNamed(context, RoutePath.baseSlideContent);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: TextButton(
                          onPressed: () {
                            RouteUtils.pushForNamed(context, RoutePath.baseSlideContent);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.play_arrow_sharp),
                              const SizedBox(width: 8.0),
                              const Text("立即放映"),
                              const SizedBox(width: 8.0),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
            ]),
            Container(

              margin: const EdgeInsets.only(left: 16,top: 0,right: 16,bottom: 0),
              child: Text("适用于2025年度浙江工业大学大学生智能汽车竞赛实验室参观展示，包含BOOM8、BOOM9、独轮车模等。",style: TextStyle(fontSize: 16.0),)
            ),

            Container(
              margin: const EdgeInsets.only(left: 16,top: 16,right: 16,bottom: 0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0),
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/icon/xiaobai.jpg"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 0.0),
                  SizedBox(
                    width: 200,
                    child: ListTile(
                      title: Text(
                        "白 展硕",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      subtitle: Text("2025年06月20日 制作", style: TextStyle(fontSize: 12.0)),
                    ),
                  )
                ],
              ),
            ),
            Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ListTile(
                  title: Text(
                    "其他演示文稿",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ]),
            // 使用Wrap组件让卡片在水平方向自动换行
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [

                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: SlideHomeCard(
                      title: "默认演示",
                      description: "",
                    ),
                    width: 200,
                    height: 100,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: SlideHomeCard(
                      title: "默认演示",
                      description: "",
                    ),
                    width: 200,
                    height: 100,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: SlideHomeCard(
                      title: "默认演示",
                      description: "",
                    ),
                    width: 200,
                    height: 100,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: SlideHomeCard(
                      title: "默认演示",
                      description: "",
                    ),
                    width: 200,
                    height: 100,
                  ),

                ],
              ),
            ),
            // 增加一些空空间来测试滚动
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}