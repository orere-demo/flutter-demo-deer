import 'package:demo2_deer/res/constant.dart';
// import 'package:';
// import 'dart:convert';

class BaseEntity<T> {
  BaseEntity(this.code, this.message, this.data);

  BaseEntity.formJson(Map<String, dynamic> json) {
    // 使用 as 运算符将对象强制转换为特定类型
    code = json[Constant.code] as int;
    message = json[Constant.message] as String;
    if (json[Constant.data]) {
      data = _generateOBJ<T>(json[Constant.data] as Object);
    }
  }

  // late 关键词-实现延迟初始化
  late int code;
  late String message;
  T? data;

  T _generateOBJ<O>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      // List类型数据由fromJsonAsT判断处理
      // return JsonConvert.fromJsonAsT<T>(json);

      // return jsonDecode(json);
      return json as T;
    }
  }
}
