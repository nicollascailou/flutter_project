class Pet {
  String name = '';
  String race = '';
  String age = '';
  String tutorId = '';
  String petDescription = '';
  String health = '';
  String petId = '';
  String downloadUrl = '';

  Pet.empty();

  Pet(this.name, this.race, this.age, this.tutorId, this.petDescription, this.health, this.downloadUrl);

  Pet.fromJson(dynamic json) {
    name = json['name'];
    race = json['race'];
    age = json['age'];
    tutorId = json['tutorId'];
    petDescription = json['petDescription'];
    health = json['health'];
    petId = json['petId'];
    downloadUrl = json['downloadUrl'];

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['name'] = name;
    json['race'] = race;
    json['age'] = age;
    json['tutorId'] = tutorId;
    json['petDescription'] = petDescription;
    json['health'] = health;
    json['petId'] = petId;
    json['downloadUrl'] = downloadUrl;

    return json;
  }
}
