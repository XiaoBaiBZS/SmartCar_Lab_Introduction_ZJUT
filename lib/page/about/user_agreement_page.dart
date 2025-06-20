/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-20
 *@Description:
 *@Version: 1.0
 */

import 'package:flutter/material.dart';
import 'package:smart_car_lab/page/about/privacy_policy_page.dart';

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户协议')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '用户协议',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '白展硕 （以下简称“我们”）依据本协议为用户（以下简称“你”）提供 LabNav 服务。本协议对你和我们均具有法律约束力。',
            ),
            const SizedBox(height: 24),
            const Text(
              '一、本服务的功能',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '你可以使用本服务 LabNav 是一款实验室外宣大屏辅助软件，用于展示实验室风采，用户可以通过本软件在大屏上更容易的播放媒体，并通过多语言字幕来更好的对外展示实验室风采。',
            ),
            const SizedBox(height: 24),
            const Text(
              '二、责任范围及限制',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '你使用本服务得到的结果仅供参考，实际情况以官方为准。',
            ),
            const SizedBox(height: 24),
            const Text(
              '三、隐私保护',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '我们重视对你隐私的保护，你的个人隐私信息将根据《隐私政策》受到保护与规范，详情请参阅《隐私政策》。',
            ),
            const SizedBox(height: 24),
            const Text(
              '四、其他条款',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '4.1 本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。',
            ),
            const SizedBox(height: 8),
            const Text(
              '4.2 本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。',
            ),
            const SizedBox(height: 24),
            const Text(
              '五、应用授权',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '5.1 当前使用的应用版本是开发者 白展硕 授权给 浙江工业大学智能汽车俱乐部 使用的版本。仅可用作 智能汽车竞赛参观讲解辅助 使用，不得在其他场景使用，不可以以任何方式修改软件内文件和对软件重新打包。',
            ),
            const SizedBox(height: 8),
            const Text(
              '5.2 本软件内含的图片、音频、视频等资源，版权归浙江工业大学智能汽车俱乐部所有。开发者 白展硕 仅对其资源文件进行软件适配剪辑和编码。因软件内音视频媒体资源产生的任何问题与软件开发者无关。',
            ),
            const SizedBox(height: 8),
            const Text(
              '5.3 任何人不得在未经授权下，通过任何手段对软件进行修改或重新编译打包。如果有对软件内音视频资源进行修改或定制的需求可联系软件开发者。',
            ),
            const SizedBox(height: 8),
            const Text(
              '5.3 任何人不得在未经授权下，将本软件内任何内容用于商业用途。',
            ),

          ],
        ),
      ),
    );
  }
}