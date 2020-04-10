class MealPhoto {
  String name;
  String firebaseUrl;

  MealPhoto({this.name, this.firebaseUrl});

  MealPhoto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firebaseUrl = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.firebaseUrl;
    return data;
  }
}
