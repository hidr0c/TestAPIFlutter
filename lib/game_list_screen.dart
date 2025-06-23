import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/game_item.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  _GameListScreenState createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  final ApiService apiService = ApiService();
  List<GameItem> games = []; // Updated to List<GameItem>
  String? selectedPlatform;
  String? selectedCategory;
  String? selectedSortBy;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  @override
  void dispose() {
    apiService.dispose(); // Close the Dio client
    super.dispose();
  }

  Future<void> fetchGames() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final fetchedGames = await apiService.getListGames();
      setState(() {
        games = fetchedGames;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load games: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    }
  }

  Future<void> applyFilters() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      List<GameItem> filteredGames;
      if (selectedPlatform != null) {
        filteredGames = await apiService.getGamesByPlatform(selectedPlatform!);
      } else if (selectedCategory != null) {
        filteredGames = await apiService.getGamesByCategory(selectedCategory!);
      } else if (selectedSortBy != null) {
        filteredGames = await apiService.getGamesSortedBy(selectedSortBy!);
      } else {
        filteredGames = await apiService.getListGames();
      }
      setState(() {
        games = filteredGames;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to apply filters: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    }
  }

  void resetFiltersExcept(String? filterType) {
    setState(() {
      if (filterType != 'platform') selectedPlatform = null;
      if (filterType != 'category') selectedCategory = null;
      if (filterType != 'sortBy') selectedSortBy = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 16.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: const Text('Platform'),
                  value: selectedPlatform,
                  items: ['pc', 'browser', 'all']
                      .map((platform) => DropdownMenuItem(
                            value: platform,
                            child: Text(platform),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      resetFiltersExcept('platform');
                      selectedPlatform = value;
                    });
                    applyFilters();
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Category'),
                  value: selectedCategory,
                  items: [
                    'mmorpg',
                    'shooter',
                    'strategy',
                    'moba',
                    'racing',
                    'sports',
                    'social',
                    'sandbox',
                    'open-world',
                    'survival',
                    'pvp',
                    'pve',
                    'pixel',
                    'voxel',
                    'zombie',
                    'turn-based',
                    'first-person',
                    'third-person', // Fixed capitalization
                    'top-down',
                    'tank',
                    'space',
                    'sailing',
                    'side-scroller',
                    'superhero',
                    'permadeath',
                    'card',
                    'battle-royale',
                    'mmo',
                    'mmofps',
                    'mmotps',
                    '3d',
                    '2d',
                    'anime',
                    'fantasy',
                    'sci-fi',
                    'fighting',
                    'action-rpg',
                    'action',
                    'military',
                    'martial-arts',
                    'flight',
                    'low-spec',
                    'tower-defense',
                    'horror',
                    'mmorts'
                  ]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      resetFiltersExcept('category');
                      selectedCategory = value;
                    });
                    applyFilters();
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Sort By'),
                  value: selectedSortBy,
                  items: ['release-date', 'popularity', 'alphabetical', 'relevance']
                      .map((sortBy) => DropdownMenuItem(
                            value: sortBy,
                            child: Text(sortBy),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      resetFiltersExcept('sortBy');
                      selectedSortBy = value;
                    });
                    applyFilters();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(errorMessage!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: fetchGames,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : games.isEmpty
                        ? const Center(child: Text('No games found'))
                        : ListView.builder(
                            itemCount: games.length,
                            itemBuilder: (context, index) {
                              final game = games[index];
                              return ListTile(
                                leading: game.thumbnail != null
                                    ? Image.network(
                                        game.thumbnail!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                      )
                                    : null,
                                title: Text(game.title ?? 'No Title'),
                                subtitle: Text(
                                  '${game.shortDescription ?? 'No Description'}\nPlatform: ${game.platform ?? 'Unknown'}',
                                ),
                                onTap: () {
                                  // Optional: Navigate to game detail screen
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => GameDetailScreen(gameId: game.id!),
                                  //   ),
                                  // );
                                },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}