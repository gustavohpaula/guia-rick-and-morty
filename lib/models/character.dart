class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String locationName;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? 'unknown',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      originName: json['origin'] != null ? json['origin']['name'] ?? '' : '',
      locationName:
          json['location'] != null ? json['location']['name'] ?? '' : '',
    );
  }
}
