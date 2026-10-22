import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../providers/wishlist_provider.dart';
import '../utils/constants.dart';
import '../widgets/empty_state_view.dart';
import 'details_screen.dart';

/// WishlistScreen displays all destinations saved by the user.
/// Supports:
/// - Real-time synchronization everywhere
/// - Individual item deletion with visual swipe or trash icon
/// - "Clear All" action with safety confirmation dialog
/// - Friendly illustrated empty state with direct action to explore
class WishlistScreen extends StatelessWidget {
  final VoidCallback? onExploreTap;

  const WishlistScreen({
    super.key,
    this.onExploreTap,
  });

  /// Confirm and clear the entire wishlist
  Future<void> _showClearConfirmationDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Wishlist?'),
        content: const Text(
          'Are you sure you want to remove all destinations from your wishlist?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.wishlistRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<WishlistProvider>().clearWishlist();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wishlist cleared'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final wishlistProvider = context.watch<WishlistProvider>();
    final savedDestinations = wishlistProvider.savedDestinations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          if (savedDestinations.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.wishlistRed),
              tooltip: 'Clear Wishlist',
              onPressed: () => _showClearConfirmationDialog(context),
            ),
        ],
      ),
      body: savedDestinations.isEmpty
          ? EmptyStateView(
              icon: Icons.favorite_border_rounded,
              title: 'Your wishlist is empty',
              message:
                  'Discover breathtaking destinations across India and tap the heart icon to save your favourites.',
              actionLabel: 'Explore Destinations',
              onAction: onExploreTap,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: savedDestinations.length,
              itemBuilder: (context, index) {
                final destination = savedDestinations[index];
                return _buildWishlistTile(context, destination, isDark);
              },
            ),
    );
  }

  Widget _buildWishlistTile(
    BuildContext context,
    Destination destination,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            destination.imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                child: const Center(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.landscape_rounded),
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
            const SizedBox(height: 4),
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
            const SizedBox(height: 4),
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
          icon: const Icon(Icons.delete_outline, color: AppColors.wishlistRed),
          tooltip: 'Remove',
          onPressed: () {
            context.read<WishlistProvider>().removeDestination(destination.id);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed ${destination.name} from wishlist'),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'UNDO',
                  textColor: AppColors.accentCyan,
                  onPressed: () {
                    context.read<WishlistProvider>().toggleWishlist(destination);
                  },
                ),
              ),
            );
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
