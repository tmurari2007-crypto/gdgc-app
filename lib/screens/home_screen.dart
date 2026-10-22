import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destination_provider.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';
import '../widgets/destination_card.dart';
import '../widgets/empty_state_view.dart';
import 'details_screen.dart';
import 'matcher_screen.dart';

/// HomeScreen represents Stage 1 & Stage 3:
/// - App header with dynamic greeting and quick action buttons
/// - Live Search bar (updates query live + allows navigation to dedicated search)
/// - Category filter chips (All, Beaches, Mountains, Heritage, Adventure)
/// - 2-Column Grid of Destinations displaying images, names, locations, and instant wishlist heart toggles
/// - Seamless empty state when combined filter produces no results
class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenSearchTab;

  const HomeScreen({
    super.key,
    required this.onOpenSearchTab,
  });

  static const List<Map<String, dynamic>> _chipData = [
    {'name': 'All', 'icon': Icons.explore_outlined},
    {'name': 'Beaches', 'icon': Icons.beach_access_outlined},
    {'name': 'Mountains', 'icon': Icons.terrain_outlined},
    {'name': 'Heritage', 'icon': Icons.account_balance_outlined},
    {'name': 'Adventure', 'icon': Icons.surfing_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final destProvider = context.watch<DestinationProvider>();
    final destinations = destProvider.filteredDestinations;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Title & Action Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Namaste, Explorer',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('🇮🇳', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Travel Explorer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),

                    // Smart Matcher AI/Tool shortcut
                    IconButton.filledTonal(
                      icon: const Icon(Icons.auto_awesome, color: AppColors.primaryTeal),
                      tooltip: 'Smart Matcher',
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal.withValues(alpha: 0.12),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SmartDestinationMatcherScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Live Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  onChanged: (value) => destProvider.setSearchQuery(value),
                  decoration: InputDecoration(
                    hintText: 'Search destinations across India...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryTeal,
                      size: 22,
                    ),
                    suffixIcon: destProvider.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () => destProvider.clearSearch(),
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // Category Chips (Horizontal Scroll)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _chipData.length,
                    itemBuilder: (context, index) {
                      final item = _chipData[index];
                      final name = item['name'] as String;
                      final icon = item['icon'] as IconData;
                      final isSelected = destProvider.selectedCategory == name;

                      return CategoryChip(
                        label: name,
                        icon: icon,
                        isSelected: isSelected,
                        onTap: () => destProvider.setCategory(name),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Section Header (Results Count + Reset option)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destProvider.selectedCategory == 'All'
                          ? 'Featured Destinations'
                          : '${destProvider.selectedCategory} (${destinations.length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    if (destProvider.searchQuery.isNotEmpty ||
                        destProvider.selectedCategory != 'All')
                      GestureDetector(
                        onTap: () => destProvider.resetFilters(),
                        child: const Text(
                          'Clear Filters',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryTeal,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // 2-Column Grid or Empty State
            if (destinations.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyStateView(
                  icon: Icons.travel_explore_rounded,
                  title: 'No destinations match',
                  message:
                      'We could not find any results for "${destProvider.searchQuery}" in ${destProvider.selectedCategory}.',
                  actionLabel: 'Reset Filters',
                  onAction: () => destProvider.resetFilters(),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.76, // Elegant card proportions
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final destination = destinations[index];
                      return DestinationCard(
                        destination: destination,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DestinationDetailsScreen(
                                destination: destination,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: destinations.length,
                  ),
                ),
              ),

            // Bottom spacer for scroll comfort
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
