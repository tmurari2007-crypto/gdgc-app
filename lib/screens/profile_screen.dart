import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../utils/constants.dart';

/// ProfileScreen provides user info, app settings, GDGC VNRVJIET project info,
/// wishlist statistics, and theme toggling.
class ProfileScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const ProfileScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final wishlistProvider = context.watch<WishlistProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // User Avatar & Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: AppColors.primaryTeal.withValues(alpha: 0.15),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 50,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Travel Enthusiast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GDGC VNRVJIET Explorer',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Wishlist',
                    value: '${wishlistProvider.count}',
                    icon: Icons.favorite,
                    iconColor: AppColors.wishlistRed,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Available',
                    value: '8+',
                    icon: Icons.map,
                    iconColor: AppColors.primaryTeal,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Categories',
                    value: '4',
                    icon: Icons.category,
                    iconColor: AppColors.accentCyan,
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Settings List
            _buildSectionHeader('Preferences', isDark),
            const SizedBox(height: 10),

            _buildSettingsTile(
              context,
              icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
              title: 'Dark Mode',
              subtitle: isDarkMode ? 'Currently On' : 'Currently Off',
              trailing: Switch(
                value: isDarkMode,
                activeThumbColor: AppColors.primaryTeal,
                onChanged: (_) => onToggleTheme(),
              ),
              isDark: isDark,
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('About Application', isDark),
            const SizedBox(height: 10),

            _buildSettingsTile(
              context,
              icon: Icons.info_outline,
              title: 'GDGC App Development Assignment',
              subtitle: 'Travel Explorer for VNRVJIET recruitment',
              isDark: isDark,
            ),
            _buildSettingsTile(
              context,
              icon: Icons.code,
              title: 'Architecture & Tech Stack',
              subtitle: 'Flutter 3, Provider, Material 3, Open-Meteo',
              isDark: isDark,
            ),
            _buildSettingsTile(
              context,
              icon: Icons.storage,
              title: 'Local Persistence',
              subtitle: 'Wishlist synced with SharedPreferences',
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryTeal),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
