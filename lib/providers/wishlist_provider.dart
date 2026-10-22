import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';

/// WishlistProvider handles reactive state management for user wishlist.
/// Implements local persistence using `shared_preferences` so saved destinations
/// survive app restarts.
class WishlistProvider with ChangeNotifier {
  static const String _storageKey = 'travel_explorer_wishlist_ids';

  // Set of saved destination IDs for fast O(1) lookups
  final Set<String> _wishlistIds = {};

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  WishlistProvider() {
    _loadFromPreferences();
  }

  /// Returns unmodifiable list of saved destination IDs
  List<String> get wishlistIds => _wishlistIds.toList();

  /// Total count of saved items
  int get count => _wishlistIds.length;

  /// Returns full Destination objects corresponding to saved IDs
  List<Destination> get savedDestinations {
    return kStaticDestinations
        .where((dest) => _wishlistIds.contains(dest.id))
        .toList();
  }

  /// Check if a destination is currently in the wishlist
  bool isWishlisted(String destinationId) {
    return _wishlistIds.contains(destinationId);
  }

  /// Toggle wishlist state for a destination:
  /// Adds if not present, removes if already present.
  /// Returns `true` if added, `false` if removed.
  bool toggleWishlist(Destination destination) {
    final wasWishlisted = _wishlistIds.contains(destination.id);
    if (wasWishlisted) {
      _wishlistIds.remove(destination.id);
    } else {
      _wishlistIds.add(destination.id);
    }

    _saveToPreferences();
    notifyListeners();
    return !wasWishlisted;
  }

  /// Remove a destination directly from the wishlist
  void removeDestination(String destinationId) {
    if (_wishlistIds.remove(destinationId)) {
      _saveToPreferences();
      notifyListeners();
    }
  }

  /// Clear all destinations from the wishlist
  void clearWishlist() {
    if (_wishlistIds.isNotEmpty) {
      _wishlistIds.clear();
      _saveToPreferences();
      notifyListeners();
    }
  }

  // ------------------- PERSISTENCE (EXTENSION) -------------------

  /// Load persisted wishlist IDs from SharedPreferences
  Future<void> _loadFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList = prefs.getStringList(_storageKey);
      if (savedList != null) {
        _wishlistIds.addAll(savedList);
      }
    } catch (e) {
      debugPrint('Error loading wishlist from SharedPreferences: $e');
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// Persist current wishlist IDs to SharedPreferences
  Future<void> _saveToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, _wishlistIds.toList());
    } catch (e) {
      debugPrint('Error saving wishlist to SharedPreferences: $e');
    }
  }
}
