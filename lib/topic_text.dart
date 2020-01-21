library topic_text;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TopicText extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color topicColor;
  final Color atColor;
  final Color urlColor;
  final double fontSize;
  final ValueChanged onAtTap;
  final ValueChanged onUrlTap;
  final ValueChanged onTopicTap;

  TopicText(this.text,
      {this.topicColor = Colors.blue,
      this.textColor = const Color(0xff4a4a4a),
      this.atColor = Colors.blue,
      this.urlColor = Colors.blue,
      this.fontSize = 14,
      this.onAtTap,
      this.onUrlTap,
      this.onTopicTap});

  @override
  _TopicTextState createState() => _TopicTextState();
}

class _TopicTextState extends State<TopicText> {
  static const String URL =
      '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]';
  static const String AT = '@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}'; // @人
  static const String TOPIC = '#[^#]+#'; // ##话题
  static const String ALL =
      "(" + URL + ")" + "|" + "(" + AT + ")" + "|" + "(" + TOPIC + ")";

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
    List<String> texts = List();
    int start = 0;
    RegExp pattern = RegExp(ALL);
    Iterable<RegExpMatch> matches = pattern.allMatches(text);
    matches.forEach((match) {
      if (start != match.start) {
        texts.add(text.substring(start, match.start));
      }
      texts.add(text.substring(match.start, match.end));
      start = match.end;
    });
    if(start != text.length){
      texts.add(text.substring(start));
    }
    return texts;
  }

  TextSpan _build(String e) {
    if (e.indexOf(new RegExp(URL)) != -1) {
      return TextSpan(
          text: e,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (widget.onUrlTap != null) {
                widget.onUrlTap(e);
              }
            },
          style: TextStyle(color: widget.urlColor, fontSize: widget.fontSize));
    } else if (e.indexOf(new RegExp(TOPIC)) != -1) {
      return TextSpan(
          text: e,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (widget.onTopicTap != null) {
                widget.onTopicTap(e);
              }
            },
          style:
              TextStyle(color: widget.topicColor, fontSize: widget.fontSize));
    } else if (e.indexOf(new RegExp(AT)) != -1) {
      return TextSpan(
          text: e,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (widget.onAtTap != null) {
                widget.onAtTap(e);
              }
            },
          style: TextStyle(color: widget.atColor, fontSize: widget.fontSize));
    } else {
      return TextSpan(
          text: e,
          style: TextStyle(color: widget.textColor, fontSize: widget.fontSize));
    }
  }
}
