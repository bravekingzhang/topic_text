//import 'package:flutter_test/flutter_test.dart';
///参考
///https://blog.csdn.net/hfut_jf/article/details/49745701
//import 'package:topic_text/topic_text.dart';

void main() {
  String content = "今年有http://www.tip.com?key=552&pa=122的好片#庆余年#方@范冰冰#2020好片#真心好看";
  const String URL =
      '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]';
  const String AT = '@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}'; // @人
  const String TOPIC = '#[^#]+#'; // ##话题
  const String ALL =
      "(" + URL + ")" + "|" + "(" + AT + ")" + "|" + "(" + TOPIC + ")";

  RegExp pattern = RegExp(ALL);
  List<String> texts = List();
  int start = 0;
  Iterable<RegExpMatch> matches = pattern.allMatches(content);
  matches.forEach((match) {
    if(start != match.start){
      texts.add(content.substring(start,match.start));
    }
    texts.add(content.substring(match.start,match.end));
    start = match.end;
  });

  texts.forEach(print);
}
