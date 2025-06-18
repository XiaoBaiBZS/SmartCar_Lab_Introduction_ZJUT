import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:smart_car_lab/class/setting.dart';

/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description: 字幕语言设置页面
 *@Version: 1.0
 */

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? selectedFirstSubtitleLanguageValue;
  String? selectedSecondSubtitleLanguageValue;

  final List<String> items = [
    'cn 简体中文',
    'en 英语',
    'vi 越南语',
    'kr 韩语',
    'ru 俄语',
    'ja 日本语',
    'fr 法语',
  ];

  @override
  void initState() {
    super.initState();
    // 初始化加载保存的设置
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 这里可以添加异步加载保存的设置逻辑
      setState(() {
        selectedFirstSubtitleLanguageValue = Settings.getValue<String>(Setting.mainSrt,);
        selectedSecondSubtitleLanguageValue = Settings.getValue<String>(Setting.secondSrt,);
      });
    });
  }

  /// 创建下拉选择器组件
  Widget buildDropdown({
    required String? value,
    required Function(String?) onChanged,
    required String hintText,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hintText),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      elevation: 16,

      underline: Container(
        height: 2,

      ),
      isExpanded: true,
    );
  }

  void saveSettings() {
    // 保存设置逻辑
    Settings.setValue(Setting.mainSrt, selectedFirstSubtitleLanguageValue);
    Settings.setValue(Setting.secondSrt, selectedSecondSubtitleLanguageValue);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '字幕语言选择',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("第一字幕语言"),
                      subtitle: buildDropdown(
                        value: selectedFirstSubtitleLanguageValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedFirstSubtitleLanguageValue = newValue;
                            // 防止两种语言选择相同
                            if (newValue == selectedSecondSubtitleLanguageValue) {
                              selectedSecondSubtitleLanguageValue = null;
                            }
                          });
                          saveSettings();
                        },
                        hintText: selectedFirstSubtitleLanguageValue??'请选择第一字幕语言',
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("第二字幕语言"),
                      subtitle: buildDropdown(
                        value: selectedSecondSubtitleLanguageValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSecondSubtitleLanguageValue = newValue;
                            // 防止两种语言选择相同
                            if (newValue == selectedFirstSubtitleLanguageValue) {
                              selectedFirstSubtitleLanguageValue = null;
                            }
                          });
                          saveSettings();
                        },
                        hintText: selectedSecondSubtitleLanguageValue??'请选择第二字幕语言',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}