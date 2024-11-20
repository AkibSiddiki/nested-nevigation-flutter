import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings settings) {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => _getTabScreen(index, settings.name, args),
          );
        },
      ),
    );
  }

  Widget _getTabScreen(
      int index, String? routeName, Map<String, dynamic>? args) {
    switch (index) {
      case 0:
        if (routeName == '/details') {
          return DetailsScreen(slug: args?['slug'] ?? 'Home');
        }
        return const HomeScreen();
      case 1:
        if (routeName == '/details') {
          return DetailsScreen(slug: args?['slug'] ?? 'Search');
        }
        return const SearchScreen();
      case 2:
        if (routeName == '/details') {
          return DetailsScreen(slug: args?['slug'] ?? 'Profile');
        }
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(
          _navigatorKeys.length,
          (index) => _buildOffstageNavigator(index),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: {'slug': 'Home'},
            );
          },
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: {'slug': 'Search'},
            );
          },
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: {'slug': 'Profile'},
            );
          },
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String slug;
  const DetailsScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details from $slug')),
      body: Center(
        child: Text('Details Screen from $slug'),
      ),
    );
  }
}
