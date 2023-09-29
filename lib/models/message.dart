class Message {
  String? user;
  String? text;
  String? time;

  Message({this.user, this.text, this.time});

  Message.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['text'] = this.text;
    data['time'] = this.time;
    return data;
  }
}
