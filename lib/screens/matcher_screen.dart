import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../providers/destination_provider.dart';
import '../utils/constants.dart';
import '../widgets/destination_card.dart';
import 'details_screen.dart';

/// SmartDestinationMatcherScreen allows users to input their travel preferences:
/// 1. Category (Beaches, Mountains, Heritage, Adventure, or Any)
/// 2. Budget Level (Low, Medium, High, or Any)
/// 3. Trip Duration (Days)
/// The app runs an intelligent matching filter and presents tailored recommendations.
class SmartDestinationMatcherScreen extends StatefulWidget {
  const SmartDestinationMatcherScreen({super.key});

  @override
  State<SmartDestinationMatcherScreen> createState() =>
      _SmartDestinationMatcherScreenState();
}

class _SmartDestinationMatcherScreenState
    extends State<SmartDestinationMatcherScreen> {
  DestinationCategory? _selectedCategory;
  BudgetLevel? _selectedBudget;
  double _maxDays = 5.0;

  List<Destination>? _matchedResults;

  void _runMatcher() {
    final provider = context.read<DestinationProvider>();
    final results = provider.matchDestinations(
      category: _selectedCategory,
      budget: _selectedBudget,
      maxDays: _maxDays.toInt(),
    );

    setState(() {
      _matchedResults = results;
    });
  }

  void _reset() {
    setState(() {
      _selectedCategory = null;
      _selectedBudget = null;
      _maxDays = 5.0;
      _matchedResults = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Matcher'),
        actions: [
          if (_matchedResults != null ||
              _selectedCategory != null ||
              _selectedBudget != null)
            TextButton(
              onPressed: _reset,
              child: const Text('Reset', style: TextStyle(color: AppColors.primaryTeal)),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryTeal, AppColors.accentCyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 36),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Your Ideal Trip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tell us your style, budget & duration, and we\'ll suggest the best spots in India.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 1. SELECT CATEGORY
            Text(
              '1. Travel Vibe',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Any Vibe'),
                  selected: _selectedCategory == null,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = null);
                  },
                ),
                ...DestinationCategory.values.map(
                  (cat) => ChoiceChip(
                    label: Text(cat.displayName),
                    selected: _selectedCategory == cat,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? cat : null;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 2. BUDGET LEVEL
            Text(
              '2. Budget Preference',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Any Budget'),
                  selected: _selectedBudget == null,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedBudget = null);
                  },
                ),
                ...BudgetLevel.values.map(
                  (lvl) => ChoiceChip(
                    label: Text(lvl.label),
                    selected: _selectedBudget == lvl,
                    onSelected: (selected) {
                      setState(() {
                        _selectedBudget = selected ? lvl : null;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 3. TRIP DURATION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '3. Max Trip Duration',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  '${_maxDays.toInt()} Days',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTeal,
                  ),
                ),
              ],
            ),
            Slider(
              value: _maxDays,
              min: 2,
              max: 10,
              divisions: 8,
              activeColor: AppColors.primaryTeal,
              label: '${_maxDays.toInt()} days',
              onChanged: (val) {
                setState(() => _maxDays = val);
              },
            ),

            const SizedBox(height: 18),

            // MATCH BUTTON
            ElevatedButton.icon(
              onPressed: _runMatcher,
              icon: const Icon(Icons.bolt, color: Colors.white),
              label: const Text(
                'Match My Travel Plan',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // RESULTS DISPLAY
            if (_matchedResults != null) ...[
              Text(
                'Matching Destinations (${_matchedResults!.length})',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 12),
              if (_matchedResults!.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'No destinations perfectly matched all constraints.\nTry extending your days or choosing "Any Budget".',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _matchedResults!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.76,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final destination = _matchedResults![index];
                    return DestinationCard(
                      destination: destination,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DestinationDetailsScreen(destination: destination),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
