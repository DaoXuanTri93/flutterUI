

import "package:universal_html/html.dart";

String? getToken(String key){
  final cookies =  document.cookie?.split('; ') ?? [];
  for (var cookie in cookies){
    var part =cookie.split("=");
    var name = Uri.decodeComponent(part[0]);
    if(key == name){
      return part[1].isNotEmpty ? Uri.decodeComponent(part[1]): null;
    }
  }
  return null;
 }

  void setToken(String key, String value){
   var cookie =([Uri.encodeComponent(key),'=',Uri.encodeComponent(value)].join(''));
   document.cookie = cookie;
  }

  bool removeToken(String key){
      if(getToken(key) != null){
        setToken(key, "");
        return true;
      }
      return false;
  }