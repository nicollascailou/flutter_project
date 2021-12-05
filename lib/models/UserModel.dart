class UserModel {
  String name = '';
  String phone = '';
  String birthDate = '';
  String id = '';
  String addres = '';

  UserModel.empty();

  UserModel(this.name, this.phone, this.birthDate, this.addres, this.id,);

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    id = json['id'];
    addres = json['addres'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['name'] = name;
    json['phone'] = phone;
    json['birthDate'] = birthDate;
    json['id'] = id;
    json['addres'] = addres;

    return json;
  }
}
