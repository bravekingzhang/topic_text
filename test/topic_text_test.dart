//import 'package:flutter_test/flutter_test.dart';

//import 'package:topic_text/topic_text.dart';

void main() {
  var regexp =  new RegExp(r"#.*#");
  var content = "鸟粪#哦挖#方";
  String match="";
  RegExpMatch regExpMatch = regexp.firstMatch(content);
  if(regExpMatch !=null){
    match = regExpMatch.group(0);
  }
  print(match);
}
