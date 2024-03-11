import 'package:flutter/material.dart';
import 'package:netfli_project/api/api_constants.dart';
import 'package:netfli_project/api/api_service.dart';
import 'package:netfli_project/api/model_json.dart';
import 'package:netfli_project/movies/movie_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ApiDataModel> _searchResults = [];
  final List<String> _popularSearches = [
    'Action',
    'Comedy',
    'Thriller',
    'Romance',
    'Horror',
    'Sci-Fi',
  ]; // Add popular searches here
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for a show, Movies, genre...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchTextChanged,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _performSearch(_searchController.text);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Popular Searches",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _popularSearches
                          .map((search) => Padding(
                                padding: const EdgeInsets.only(right: 11.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _performSearch(search);
                                  },
                                  child: Text(search),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSearchResults(),
                ],
              ),
            ),
    );
  }

  void _onSearchTextChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false; // Reset loading state
      });
      return;
    }

    setState(() {
      _isLoading = true; // Set loading state
    });

    try {
      final movies = await MovieService().searchMovies(value);
      setState(() {
        _searchResults = movies;
        _isLoading = false; // Reset loading state
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false; // Reset loading state
        _searchResults = [];
      });
    }
  }

  void _performSearch(String query) async {
    _searchController.text = query; // Update the text field with the query
    _onSearchTextChanged(query); // Perform search
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(''),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.7,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final movie = _searchResults[index];
        return InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${ApiConfig.imagePath}${movie.poster}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () {
            _navigateToMovieDetails(movie);
          },
        );
      },
    );
  }

  void _navigateToMovieDetails(ApiDataModel movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }
}