import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/api/api_services.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movie_app/features/home/data/models/home_response.dart';
import 'package:movie_app/features/home/data/repository/home_repository_impl.dart';
import 'package:movie_app/features/search/presentation/views/widgets/search_form_field.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _controller = TextEditingController();
  final HomeRepositoryImpl _repo =
      HomeRepositoryImpl(HomeRemoteDataSource(apiService: ApiService(Dio())));
  List<Movie> _results = [];
  String _query = '';
  bool _isLoading = false;

  Future<void> _search(String query) async {
    setState(() {
      _isLoading = true;
      _query = query;
    });

    final results = await _repo.searchMovies(query);

    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchFormField(
                controller: _controller,
                onSubmitted: _search,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _results.clear();
                      _query = '';
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _query.isEmpty
                      ? Center(
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              AssetManager.empty, 
                              width: 150,
                            ),
                          ),
                        )
                      : _results.isEmpty
                          ? const Center(
                              child: Text(
                                'No results found.',
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _results.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.6,
                              ),
                              itemBuilder: (context, index) {
                                final movie = _results[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        movie.image,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.8),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 8,
                                        right: 8,
                                        bottom: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '⭐ ${movie.rating.toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                color: Colors.amber,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              movie.releaseDate,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
