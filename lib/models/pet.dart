class Pet {
  String name = '';
  String race = '';
  String age = '';
  String tutorId = '';
  String petId = '';

  Pet.empty();

  Pet(this.name, this.race, this.age, this.tutorId);

  Pet.fromJson(dynamic json) {
    name = json['name'];
    race = json['race'];
    age = json['age'];
    tutorId = json['tutorId'];
    petId = json['petId'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['name'] = name;
    json['race'] = race;
    json['age'] = age;
    json['tutorId'] = tutorId;
    json['petId'] = petId;

    return json;
  }
}
