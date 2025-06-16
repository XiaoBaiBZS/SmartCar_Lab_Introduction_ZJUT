/// title : "title"
/// discription : "disccription"
/// author : "author"
/// data : [{"id":0,"title":"欢迎","type":"image","media":"","srt":""},{"id":1,"title":"观看介绍短片","type":"video","media":"","srt":""}]

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
/// media : ""
/// srt : ""

class Data {
  Data({
    this.id,
    this.title,
    this.type,
    this.media,
    this.srt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    media = json['media'];
    srt = json['srt'];
  }
  num? id;
  String? title;
  String? type;
  String? media;
  String? srt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['media'] = media;
    map['srt'] = srt;
    return map;
  }

}

enum SlideType {
  image,
  video,
}