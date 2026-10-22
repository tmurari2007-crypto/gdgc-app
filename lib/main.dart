import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/destination_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/wishlist_screen.dart';
import 'utils/constants.dart';
import 'utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TravelExplorerApp());
}

/// Root widget for the Travel Explorer application.
/// Initializes multi-providers (DestinationProvider, WishlistProvider)
/// and ThemeMode state management.
class TravelExplorerApp extends StatefulWidget {
  const TravelExplorerApp({super.key});

  @override
  State<TravelExplorerApp> createState() => _TravelExplorerAppState();
}

class _TravelExplorerAppState extends State<TravelExplorerApp> {
  // Theme state: defaults to light mode with instant toggle in Profile tab
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'Travel Explorer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: MainNavigationContainer(
          onToggleTheme: _toggleTheme,
          isDarkMode: _themeMode == ThemeMode.dark,
        ),
      ),
    );
  }
}

/// MainNavigationContainer holds the persistent BottomNavigationBar
/// with 4 tabs:
/// 1. Home (Stage 1 Destination Discovery + Category chips + Grid)
/// 2. Explore / Search (Stage 3 Live search & filter tab)
/// 3. Wishlist (Stage 4 Travel Wishlist with real-time badges)
/// 4. Profile (Theme switch, project stats, GDGC details)
class MainNavigationContainer extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MainNavigationContainer({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainNavigationContainer> createState() =>
      _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = context.watch<WishlistProvider>();
    final wishlistCount = wishlistProvider.count;

    final screens = [
      HomeScreen(
        onOpenSearchTab: () => setState(() => _currentIndex = 1),
      ),
      const SearchScreen(),
      WishlistScreen(
        onExploreTap: () => setState(() => _currentIndex = 0),
      ),
      ProfileScreen(
        onToggleTheme: widget.onToggleTheme,
        isDarkMode: widget.isDarkMode,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: wishlistCount > 0,
              label: Text('$wishlistCount'),
              backgroundColor: AppColors.wishlistRed,
              child: const Icon(Icons.favorite_outline),
            ),
            activeIcon: Badge(
              isLabelVisible: wishlistCount > 0,
              label: Text('$wishlistCount'),
              backgroundColor: AppColors.wishlistRed,
              child: const Icon(Icons.favorite),
            ),
            label: 'Wishlist',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
