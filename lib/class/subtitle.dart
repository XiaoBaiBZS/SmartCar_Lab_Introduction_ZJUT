/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-14
 *@Description:
 *@Version: 1.0
 */

class Subtitle {
  int index;            // 字幕序号
  Duration startTime;   // 开始时间
  Duration endTime;     // 结束时间
  String text;          // 字幕文本

  Subtitle({
    required this.index,
    required this.startTime,
    required this.endTime,
    required this.text,
  });

  @override
  String toString() {
    return 'Subtitle $index: ${_formatTime(startTime)} --> ${_formatTime(endTime)}\n$text';
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String threeDigitMillis = twoDigits(duration.inMilliseconds.remainder(1000)).padLeft(3, '0');
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds,$threeDigitMillis';
  }
}