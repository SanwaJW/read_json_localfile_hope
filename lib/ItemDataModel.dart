class ItemDataModel {
  String? id;
  String? name;
  String? description;
  String? dateOfBirth;
  String? dateOfJoin;

  ItemDataModel({
    this.id,
    this.name,
    this.description,
    this.dateOfBirth,
    this.dateOfJoin,
  });

  // Factory method to create an instance of ItemDataModel from a JSON map

  ItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    dateOfBirth = json['dateOfBirth'];
    dateOfJoin = json['dateOfJoin'];
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'dateOfBirth': dateOfBirth,
        'dateOfJoin': dateOfJoin,
      };
}
