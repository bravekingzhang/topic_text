library topic_text;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TopicText extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color topicColor;
  final double fontSize;
  final GestureTapCallback onTab;

  TopicText(this.text,
      {this.topicColor = Colors.blue,
      this.textColor = const Color(0xff4a4a4a),
      this.fontSize = 14,
      this.onTab});

  @override
  _TopicTextState createState() => _TopicTextState();
}

class _TopicTextState extends State<TopicText> {
  List<String> texts;

  @override
  void initState() {
    super.initState();
    texts = extractText(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: texts.map(_build).toList()));
  }

  List<String> extractText(String text) {
    var regexp = new RegExp(r"#.*#");
    String match = "";
    RegExpMatch regExpMatch = regexp.firstMatch(text);
    if (regExpMatch != null) {
      match = regExpMatch.group(0);
    }
    if (match.isEmpty) {
      return [text];
    } else {
      int index = text.indexOf(regexp);
      List<String> lists = text.split(regexp);
      if (index == 0) {
        lists.insert(0, match);
      } else {
        lists.insert(1, match);
      }
      return lists;
    }
  }

  TextSpan _build(String e) {
    if (e.indexOf(new RegExp(r"#.*#")) != -1) {
      return TextSpan(
          text: e,
          recognizer: TapGestureRecognizer()
            ..onTap = widget.onTab == null ? () {} : widget.onTab,
          style:
              TextStyle(color: widget.topicColor, fontSize: widget.fontSize));
    } else {
      return TextSpan(
          text: e,
          style: TextStyle(color: widget.textColor, fontSize: widget.fontSize));
    }
  }
}
