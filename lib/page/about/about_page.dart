import 'package:flutter/material.dart';
import 'package:smart_car_lab/route/route_utils.dart';
import 'package:smart_car_lab/route/routes.dart';
import 'package:smart_car_lab/widegt/tv_focus_widget.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 应用标题和Logo
            Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(56.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56.0),
                        color: colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/icon/logo.png",
                        width: 56,
                        height: 56,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LabNav",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "实验室外宣大屏辅助",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 应用信息部分
            _buildSectionTitle("应用信息"),
            const SizedBox(height: 8),
            _buildInfoCard([
              _buildInfoItem("软件版本", "1.0.0"),
              _buildInfoItem("定制版本", "浙江工大学智能车实验室"),
              _buildInfoItem("开发者", "白展硕"),
            ]),

            const SizedBox(height: 32),

            // 应用介绍部分
            _buildSectionTitle("应用介绍"),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "LabNav 是一款实验室外宣大屏辅助软件，用于展示实验室风采，用户可以通过本软件在大屏上更容易的播放媒体，并通过多语言字幕来更好的对外展示实验室风采。",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 应用合规部分
            _buildSectionTitle("应用合规"),
            const SizedBox(height: 8),
            Column(
              children: [
                TVFocusWidget(
                  focusColor: colorScheme.primary,
                  onSelect: () {
                    RouteUtils.pushForNamed(context, RoutePath.user_agreement_page);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.description, color: colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            "服务协议",
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          Icon(Icons.chevron_right, color: colorScheme.onSurface.withOpacity(0.5)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TVFocusWidget(
                  focusColor: colorScheme.primary,
                  onSelect: () {
                    RouteUtils.pushForNamed(context, RoutePath.privacy_policy_page);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.privacy_tip, color: colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            "隐私政策",
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          Icon(Icons.chevron_right, color: colorScheme.onSurface.withOpacity(0.5)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 页脚信息
            Center(
              child: Column(
                children: [
                  Text(
                    "浙江工业大学智能车实验室定制版本",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Copyright © 2025 ZhanshuoBai",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label :",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}