class RMLocation {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;

  RMLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  factory RMLocation.fromJson(Map<String, dynamic> json) {
    return RMLocation(
      id: json['id'],
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      dimension: json['dimension'] ?? '',
      residents:
          (json['residents'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
