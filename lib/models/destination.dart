import 'attraction.dart';

/// Categories supported across the app
enum DestinationCategory {
  beaches('Beaches'),
  mountains('Mountains'),
  heritage('Heritage'),
  adventure('Adventure');

  final String displayName;
  const DestinationCategory(this.displayName);

  /// Helper to convert string to enum safely
  static DestinationCategory fromString(String category) {
    return DestinationCategory.values.firstWhere(
      (c) => c.displayName.toLowerCase() == category.toLowerCase(),
      orElse: () => DestinationCategory.beaches,
    );
  }
}

/// Budget levels for the Smart Matcher extension
enum BudgetLevel {
  low('Low (Budget-friendly)'),
  medium('Medium (Comfortable)'),
  high('High (Luxury)');

  final String label;
  const BudgetLevel(this.label);
}

/// Model representing a travel destination across India.
/// Contains geographical, visual, descriptive, and matcher metadata.
class Destination {
  final String id;
  final String name;
  final String location; // State or Union Territory
  final DestinationCategory category;
  final String imageUrl;
  final String description;
  final String bestTimeToVisit;
  final double latitude;
  final double longitude;
  final List<Attraction> attractions;

  // Extension metadata for Smart Destination Matcher
  final BudgetLevel budget;
  final int idealDays; // e.g. 3, 5, 7 days recommended stay

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.bestTimeToVisit,
    required this.latitude,
    required this.longitude,
    required this.attractions,
    this.budget = BudgetLevel.medium,
    this.idealDays = 4,
  });

  /// Factory constructor to deserialize from Map
  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'] as String,
      name: map['name'] as String,
      location: map['location'] as String,
      category: DestinationCategory.fromString(map['category'] as String),
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      bestTimeToVisit: map['bestTimeToVisit'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      attractions: (map['attractions'] as List<dynamic>?)
              ?.map((item) => Attraction.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      budget: BudgetLevel.values.firstWhere(
        (b) => b.name == map['budget'],
        orElse: () => BudgetLevel.medium,
      ),
      idealDays: map['idealDays'] as int? ?? 4,
    );
  }

  /// Serialize Destination to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'category': category.displayName,
      'imageUrl': imageUrl,
      'description': description,
      'bestTimeToVisit': bestTimeToVisit,
      'latitude': latitude,
      'longitude': longitude,
      'attractions': attractions.map((a) => a.toMap()).toList(),
      'budget': budget.name,
      'idealDays': idealDays,
    };
  }
}
