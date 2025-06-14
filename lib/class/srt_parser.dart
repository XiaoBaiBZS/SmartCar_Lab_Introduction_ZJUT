import 'package:smart_car_lab/class/subtitle.dart';

/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description:
 *@Version: 1.0
 */

class SrtParser {
  // 解析SRT格式的字符串，返回字幕列表
  static List<Subtitle> parse(String srtContent) {
    final subtitles = <Subtitle>[];
    // 按空行分割不同的字幕项
    final items = srtContent.split(RegExp(r'\n\s*\n'));

    for (final item in items) {
      if (item.trim().isEmpty) continue;

      final lines = item.trim().split('\n');
      if (lines.length < 3) continue;

      try {
        // 解析序号
        final index = int.parse(lines[0].trim());

        // 解析时间
        final timeLine = lines[1].trim();
        final times = timeLine.split(' --> ');
        if (times.length != 2) continue;

        final startTime = _parseTime(times[0]);
        final endTime = _parseTime(times[1]);

        // 解析文本
        final text = lines.skip(2).join('\n');

        subtitles.add(Subtitle(
          index: index,
          startTime: startTime,
          endTime: endTime,
          text: text,
        ));
      } catch (e) {
        print('解析字幕项失败: $e');
      }
    }

    return subtitles;
  }

  // 将SRT时间格式解析为Duration
  static Duration _parseTime(String timeString) {
    // 示例时间格式: 00:01:23,456
    final parts = timeString.split(':');
    if (parts.length != 3) throw FormatException('时间格式不正确');

    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    final secondsParts = parts[2].split(',');
    if (secondsParts.length != 2) throw FormatException('秒和毫秒格式不正确');

    final seconds = int.parse(secondsParts[0]);
    final milliseconds = int.parse(secondsParts[1]);

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}