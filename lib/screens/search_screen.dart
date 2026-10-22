import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../providers/wishlist_provider.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state_view.dart';
import 'details_screen.dart';

/// SearchScreen allows live filtering of destinations with search input + category chips.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;

  static const List<String> _categories = [
    'All',
    'Beaches',
    'Mountains',
    'Heritage',
    'Adventure',
  ];

  @override
  void initState() {
    super.initState();
    final currentQuery = context.read<DestinationProvider>().searchQuery;
    _controller = TextEditingController(text: currentQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final destProvider = context.watch<DestinationProvider>();
    final results = destProvider.filteredDestinations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Destinations'),
      ),
      body: Column(
        children: [
          // Search input field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _controller,
              onChanged: (val) => destProvider.setSearchQuery(val),
              autofocus: false,
              style: TextStyle(
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Search by city, state, or name...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryTeal),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _controller.clear();
                          destProvider.clearSearch();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Horizontal category chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return CategoryChip(
                  label: category,
                  isSelected: destProvider.selectedCategory == category,
                  onTap: () => destProvider.setCategory(category),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Search results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${results.length} destination${results.length == 1 ? '' : 's'} found',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                if (destProvider.searchQuery.isNotEmpty ||
                    destProvider.selectedCategory != 'All')
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      destProvider.resetFilters();
                    },
                    child: const Text(
                      'Reset Filters',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 16),

          // Results List
          Expanded(
            child: results.isEmpty
                ? EmptyStateView(
                    icon: Icons.search_off_rounded,
                    title: 'No destinations found',
                    message:
                        'We couldn\'t find any destination matching "${destProvider.searchQuery}" in ${destProvider.selectedCategory}. Try another keyword or reset filters.',
                    actionLabel: 'Reset Filters',
                    onAction: () {
                      _controller.clear();
                      destProvider.resetFilters();
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final destination = results[index];
                      return _buildSearchResultTile(context, destination, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultTile(
    BuildContext context,
    Destination destination,
    bool isDark,
  ) {
    final wishlistProvider = context.watch<WishlistProvider>();
    final isWishlisted = wishlistProvider.isWishlisted(destination.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: destination.imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.landscape_rounded),
          ),
        ),
        title: Text(
          destination.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: AppColors.primaryTeal),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    destination.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              destination.category.displayName,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTeal,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            isWishlisted ? Icons.favorite : Icons.favorite_border,
            color: isWishlisted ? AppColors.wishlistRed : Colors.grey,
          ),
          onPressed: () {
            wishlistProvider.toggleWishlist(destination);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DestinationDetailsScreen(destination: destination),
            ),
          );
        },
      ),
    );
  }
}
