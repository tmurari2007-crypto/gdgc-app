import '../models/attraction.dart';
import '../models/destination.dart';

/// Static list of travel destinations across India.
/// Covers Beaches, Mountains, Heritage, and Adventure categories.
/// Includes high-resolution Unsplash direct images and realistic metadata.
final List<Destination> kStaticDestinations = [
  // ---------------- BEACHES ----------------
  const Destination(
    id: 'dest_goa',
    name: 'Goa',
    location: 'Goa',
    category: DestinationCategory.beaches,
    imageUrl:
        'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=1000&q=80',
    description:
        'Famous for its sun-kissed coastline, vibrant nightlife, and Portuguese-influenced architecture, Goa offers the ultimate tropical escape. Relax along lively shorelines or explore quiet heritage churches.',
    bestTimeToVisit: 'November to February',
    latitude: 15.2993,
    longitude: 74.1240,
    budget: BudgetLevel.medium,
    idealDays: 4,
    attractions: [
      Attraction(
        name: 'Baga Beach',
        imageUrl:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Aguada Fort',
        imageUrl:
            'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Dudhsagar Falls',
        imageUrl:
            'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
  const Destination(
    id: 'dest_andaman',
    name: 'Andaman & Nicobar',
    location: 'Andaman & Nicobar Islands',
    category: DestinationCategory.beaches,
    imageUrl:
        'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?auto=format&fit=crop&w=1000&q=80',
    description:
        'A paradise archipelago in the Bay of Bengal known for pristine white-sand beaches, coral reefs, and untouched rainforests. Perfect for scuba diving and marine adventure.',
    bestTimeToVisit: 'October to May',
    latitude: 11.7401,
    longitude: 92.6586,
    budget: BudgetLevel.high,
    idealDays: 6,
    attractions: [
      Attraction(
        name: 'Radhanagar Beach',
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Cellular Jail',
        imageUrl:
            'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Elephant Beach',
        imageUrl:
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),

  // ---------------- MOUNTAINS ----------------
  const Destination(
    id: 'dest_manali',
    name: 'Manali',
    location: 'Himachal Pradesh',
    category: DestinationCategory.mountains,
    imageUrl:
        'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?auto=format&fit=crop&w=1000&q=80',
    description:
        'Nestled in the Beas River valley, Manali is a wonderland for mountain lovers and snow seekers. Surrounded by snow-dusted peaks, apple orchards, and pine forests.',
    bestTimeToVisit: 'October to June',
    latitude: 32.2432,
    longitude: 77.1892,
    budget: BudgetLevel.medium,
    idealDays: 5,
    attractions: [
      Attraction(
        name: 'Solang Valley',
        imageUrl:
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Rohtang Pass',
        imageUrl:
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Hadimba Temple',
        imageUrl:
            'https://images.unsplash.com/photo-1598890777032-bde835ba27c2?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
  const Destination(
    id: 'dest_shimla',
    name: 'Shimla',
    location: 'Himachal Pradesh',
    category: DestinationCategory.mountains,
    imageUrl:
        'https://images.unsplash.com/photo-1597074866923-dc0589150358?auto=format&fit=crop&w=1000&q=80',
    description:
        'The historic summer capital of British India, Shimla enchants visitors with colonial-era architecture, panoramic Himalayan vistas, and scenic walking trails along the Ridge.',
    bestTimeToVisit: 'March to June & December to January',
    latitude: 31.1048,
    longitude: 77.1734,
    budget: BudgetLevel.medium,
    idealDays: 3,
    attractions: [
      Attraction(
        name: 'The Ridge',
        imageUrl:
            'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Jakhoo Temple',
        imageUrl:
            'https://images.unsplash.com/photo-1598890777032-bde835ba27c2?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Mall Road',
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
  const Destination(
    id: 'dest_munnar',
    name: 'Munnar',
    location: 'Kerala',
    category: DestinationCategory.mountains,
    imageUrl:
        'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?auto=format&fit=crop&w=1000&q=80',
    description:
        'Perched in the Western Ghats of Kerala, Munnar is draped in emerald tea plantations, rolling mist, and cascading waterfalls. A tranquil refuge for nature enthusiasts.',
    bestTimeToVisit: 'September to March',
    latitude: 10.0889,
    longitude: 77.0595,
    budget: BudgetLevel.low,
    idealDays: 3,
    attractions: [
      Attraction(
        name: 'Tea Gardens & Museum',
        imageUrl:
            'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Eravikulam National Park',
        imageUrl:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Mattupetty Dam',
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),

  // ---------------- HERITAGE ----------------
  const Destination(
    id: 'dest_jaipur',
    name: 'Jaipur',
    location: 'Rajasthan',
    category: DestinationCategory.heritage,
    imageUrl:
        'https://images.unsplash.com/photo-1477587458883-47145ed94245?auto=format&fit=crop&w=1000&q=80',
    description:
        'The illustrious "Pink City" of Rajasthan is renowned for its grand royal palaces, formidable hill forts, and colourful artisan bazaars steeped in royal Rajput history.',
    bestTimeToVisit: 'October to March',
    latitude: 26.9124,
    longitude: 75.7873,
    budget: BudgetLevel.medium,
    idealDays: 3,
    attractions: [
      Attraction(
        name: 'Hawa Mahal',
        imageUrl:
            'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Amer Fort',
        imageUrl:
            'https://images.unsplash.com/photo-1602940659805-770d1b3b9911?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'City Palace',
        imageUrl:
            'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
  const Destination(
    id: 'dest_hampi',
    name: 'Hampi',
    location: 'Karnataka',
    category: DestinationCategory.heritage,
    imageUrl:
        'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=1000&q=80',
    description:
        'A UNESCO World Heritage site featuring the majestic boulder-strewn ruins of the Vijayanagara Empire. Marvel at stone chariots, towering gopurams, and riverside temple complexes.',
    bestTimeToVisit: 'October to February',
    latitude: 15.3350,
    longitude: 76.4600,
    budget: BudgetLevel.low,
    idealDays: 3,
    attractions: [
      Attraction(
        name: 'Virupaksha Temple',
        imageUrl:
            'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Vijaya Vittala Stone Chariot',
        imageUrl:
            'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Matanga Hill',
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),

  // ---------------- ADVENTURE ----------------
  const Destination(
    id: 'dest_rishikesh',
    name: 'Rishikesh',
    location: 'Uttarakhand',
    category: DestinationCategory.adventure,
    imageUrl:
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=1000&q=80',
    description:
        'The Yoga Capital of the World and premier adventure hub along the holy Ganges. Famous for white-water river rafting, bungee jumping, and cliff-jumping into emerald waters.',
    bestTimeToVisit: 'September to November & March to May',
    latitude: 30.0869,
    longitude: 78.2676,
    budget: BudgetLevel.low,
    idealDays: 3,
    attractions: [
      Attraction(
        name: 'Ganges White Water Rafting',
        imageUrl:
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Lakshman Jhula',
        imageUrl:
            'https://images.unsplash.com/photo-1598890777032-bde835ba27c2?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Triveni Ghat Evening Aarti',
        imageUrl:
            'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
  const Destination(
    id: 'dest_auli',
    name: 'Auli',
    location: 'Uttarakhand',
    category: DestinationCategory.adventure,
    imageUrl:
        'https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=1000&q=80',
    description:
        'India’s top skiing destination set amidst towering Himalayan peaks like Nanda Devi. Offers scenic cable car ropeway rides, pristine snow slopes, and alpine trekking trails.',
    bestTimeToVisit: 'December to March',
    latitude: 30.5298,
    longitude: 79.5694,
    budget: BudgetLevel.high,
    idealDays: 4,
    attractions: [
      Attraction(
        name: 'Auli Ski Slopes & Ropeway',
        imageUrl:
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Auli Artificial Lake',
        imageUrl:
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=600&q=80',
      ),
      Attraction(
        name: 'Gorson Bugyal Trek',
        imageUrl:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80',
      ),
    ],
  ),
];
