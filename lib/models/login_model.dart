class LoginModel{
  bool?  status;
  String? message;
  UserData? data;


  LoginModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data=json["data"] != null ? UserData.fromJson(json["data"]) : null;
  }
}

class UserData{
  int? id;
  String? name;
  String? email;
  String? password;
  int? points;
  int? credits;
  String? token;
  String? image;
  String? phone;

  UserData(
      this.token,
      this.points,
      this.id,
      this.name,
      this.email,
      this.image,
      this.phone,
      this.password,
      this.credits,);

  UserData.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    email=json["email"];
    password=json["password"];
    image=json["image"];
    phone=json["phone"];
    points=json["points"];
    credits=json["credits"];
    token=json["token"];
  }

}

