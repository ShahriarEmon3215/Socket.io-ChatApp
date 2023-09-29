class Message {
  String? user;
  String? text;

  Message({this.user,this.text});

  Message.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['text'] = this.text;
    return data;
  }
}
