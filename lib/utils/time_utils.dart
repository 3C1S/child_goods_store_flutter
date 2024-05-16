import 'package:child_goods_store_flutter/constants/strings.dart';

String timeDiff(DateTime? time) {
  if (time == null) return Strings.nullStr;
  var now = DateTime.now();
  var diff = now.difference(time).inSeconds;

  if (diff < 60) return '방금 전';
  if (diff < 60 * 60) return '${(diff / 60).floor()}분 전';
  if (diff < 60 * 60 * 24) return '${(diff / (60 * 60)).floor()}시간 전';
  return '${(diff / (60 * 60 * 24)).floor()}일 전';
}

String timeLeft(DateTime? time) {
  if (time == null) return Strings.nullStr;
  var now = DateTime.now();
  var diff = time.difference(now).inSeconds + 1;

  if (diff <= 1) return '마감';
  if (diff < 60) return '1분 미만';
  if (diff < 60 * 60) return '${(diff / 60).floor()}분 후';
  if (diff < 60 * 60 * 24) return '${(diff / (60 * 60)).floor()}시간 후';
  return 'D-${(diff / (60 * 60 * 24)).floor()}';
}
