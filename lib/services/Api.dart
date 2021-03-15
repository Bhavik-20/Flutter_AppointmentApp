class Api {

  final List<dynamic> mon;
  final List<dynamic> tue;
  final List<dynamic> wed;
  final List<dynamic> thurs;
  final List<dynamic> fri;

  Api({this.mon, this.tue, this.wed,this.thurs,this.fri});

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
        mon: json['Monday'],
        tue: json['Tuesday'],
        wed: json['Wednesday'],
        thurs: json['Thursday'],
        fri:  json['Friday']
    );
  }
}
