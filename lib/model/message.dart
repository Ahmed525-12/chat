class Massage {
  static const String collectionName = "message";
  String id;
  String roomId;
  String content;
  int dateTime;
  String senderid;
  String senderName;
  
  Massage(
      {this.id = "",
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderid,
      required this.senderName});
  Massage.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"] as String,
          roomId: json["roomId"] as String,
          content: json["content"] as String,
          dateTime: json["dateTime"] as int,
          senderid: json["senderid"] as String,
          senderName: json["senderName"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "roomId": roomId,
      "content": content,
      "dateTime": dateTime,
      "senderid": senderid,
      "senderName": senderName,
    };
  }
}
