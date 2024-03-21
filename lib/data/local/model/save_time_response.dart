class SaveTime{
  int? id;
  String? dateTime;

  SaveTime({this.id,this.dateTime});
  factory SaveTime.fromJson(Map<String, dynamic> json)=>SaveTime(id: json["id"],dateTime: json["dataSaveTime"]);
   Map<String, dynamic> toJson()=>{
    "id":id,
    "dataSaveTime":dateTime
    };
}