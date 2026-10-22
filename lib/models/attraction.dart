/// Model representing a specific tourist attraction or point of interest
/// within a travel destination.
class Attraction {
  final String name;
  final String imageUrl;

  const Attraction({
    required this.name,
    required this.imageUrl,
  });

  /// Factory constructor to deserialize from Map (useful for local serialization / API)
  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      name: map['name'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }

  /// Serialize Attraction to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
