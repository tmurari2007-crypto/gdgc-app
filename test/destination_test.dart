import 'package:flutter_test/flutter_test.dart';
import 'package:travel_explorer/data/destinations_data.dart';
import 'package:travel_explorer/models/destination.dart';
import 'package:travel_explorer/providers/destination_provider.dart';

void main() {
  group('Destination & Provider Unit Tests', () {
    test('Destination static data has at least 8 items across 4 categories', () {
      expect(kStaticDestinations.length, greaterThanOrEqualTo(8));

      final categories = kStaticDestinations.map((d) => d.category).toSet();
      expect(categories.contains(DestinationCategory.beaches), isTrue);
      expect(categories.contains(DestinationCategory.mountains), isTrue);
      expect(categories.contains(DestinationCategory.heritage), isTrue);
      expect(categories.contains(DestinationCategory.adventure), isTrue);

      // Verify each destination has 3 attractions
      for (final dest in kStaticDestinations) {
        expect(dest.attractions.length, equals(3));
        expect(dest.name.isNotEmpty, isTrue);
        expect(dest.location.isNotEmpty, isTrue);
        expect(dest.imageUrl.isNotEmpty, isTrue);
      }
    });

    test('DestinationProvider search and category filtering work seamlessly', () {
      final provider = DestinationProvider();

      // Default state
      expect(provider.filteredDestinations.length, equals(kStaticDestinations.length));

      // Category filter: Mountains
      provider.setCategory('Mountains');
      expect(provider.filteredDestinations.every((d) => d.category == DestinationCategory.mountains), isTrue);
      expect(provider.filteredDestinations.length, equals(3)); // Manali, Shimla, Munnar

      // Combined search: 'Manali' in Mountains
      provider.setSearchQuery('Manali');
      expect(provider.filteredDestinations.length, equals(1));
      expect(provider.filteredDestinations.first.name, equals('Manali'));

      // Non-matching query
      provider.setSearchQuery('XYZ123');
      expect(provider.filteredDestinations.isEmpty, isTrue);

      // Reset
      provider.resetFilters();
      expect(provider.filteredDestinations.length, equals(kStaticDestinations.length));
    });

    test('Smart Matcher properly matches destinations by criteria', () {
      final provider = DestinationProvider();

      final matches = provider.matchDestinations(
        category: DestinationCategory.beaches,
        budget: BudgetLevel.medium,
        maxDays: 5,
      );

      expect(matches.isNotEmpty, isTrue);
      expect(matches.every((d) => d.category == DestinationCategory.beaches), isTrue);
      expect(matches.every((d) => d.budget == BudgetLevel.medium), isTrue);
      expect(matches.every((d) => d.idealDays <= 5), isTrue);
    });
  });
}
