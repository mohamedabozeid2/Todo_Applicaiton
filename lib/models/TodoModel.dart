class TodoModel{
  String? title;
  String? date;
  String? time;

  TodoModel({
    required this.title,
    required this.date,
    required this.time,
});

  TodoModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> tojson(){
    return {
      "title" : title,
      "date" : date,
      "time" : time,
    };
  }

}