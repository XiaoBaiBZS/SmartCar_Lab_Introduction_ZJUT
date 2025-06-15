/// title : "title"
/// discription : "disccription"
/// author : "author"
/// data : [{"id":0,"title":"欢迎","type":"image","asset":"","srt":""},{"id":1,"title":"观看介绍短片","type":"video","asset":"","srt":""}]

class SlideConfig {
  SlideConfig({
      this.title, 
      this.discription, 
      this.author, 
      this.data,});

  SlideConfig.fromJson(dynamic json) {
    title = json['title'];
    discription = json['discription'];
    author = json['author'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? title;
  String? discription;
  String? author;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['discription'] = discription;
    map['author'] = author;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// title : "欢迎"
/// type : "image"
/// asset : ""
/// srt : ""

class Data {
  Data({
      this.id, 
      this.title, 
      this.type, 
      this.asset, 
      this.srt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    asset = json['asset'];
    srt = json['srt'];
  }
  num? id;
  String? title;
  String? type;
  String? asset;
  String? srt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['asset'] = asset;
    map['srt'] = srt;
    return map;
  }

}