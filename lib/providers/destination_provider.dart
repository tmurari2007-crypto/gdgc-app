import 'package:flutter/foundation.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';

/// DestinationProvider manages destination querying, live search filtering,
/// category filtering, and the Smart Destination Matcher logic.
class DestinationProvider with ChangeNotifier {
  // Master list of all destinations
  final List<Destination> _allDestinations = List.unmodifiable(kStaticDestinations);

  // Filter state
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // Getters
  List<Destination> get allDestinations => _allDestinations;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  /// Returns destinations filtered simultaneously by category and search keyword.
  List<Destination> get filteredDestinations {
    return _allDestinations.where((destination) {
      // 1. Check Category match
      final matchesCategory = _selectedCategory == 'All' ||
          destination.category.displayName.toLowerCase() ==
              _selectedCategory.toLowerCase();

      // 2. Check Search query match (case-insensitive on name & location)
      final matchesSearch = _searchQuery.trim().isEmpty ||
          destination.name.toLowerCase().contains(_searchQuery.toLowerCase().trim()) ||
          destination.location.toLowerCase().contains(_searchQuery.toLowerCase().trim());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  /// Update the live search query and notify listeners
  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }

  /// Clear the search input
  void clearSearch() {
    if (_searchQuery.isNotEmpty) {
      _searchQuery = '';
      notifyListeners();
    }
  }

  /// Update the active category chip and notify listeners
  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  /// Reset all filters back to default
  void resetFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    notifyListeners();
  }

  /// Extension Feature: Smart Destination Matcher
  /// Matches destinations according to user preferences: travel category,
  /// budget level, and preferred duration in days.
  List<Destination> matchDestinations({
    required DestinationCategory? category,
    required BudgetLevel? budget,
    required int maxDays,
  }) {
    return _allDestinations.where((dest) {
      final matchesCat = category == null || dest.category == category;
      final matchesBudget = budget == null || dest.budget == budget;
      final matchesDays = dest.idealDays <= maxDays;

      return matchesCat && matchesBudget && matchesDays;
    }).toList();
  }

  /// Helper to lookup a destination by ID
  Destination? findById(String id) {
    try {
      return _allDestinations.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }
}
