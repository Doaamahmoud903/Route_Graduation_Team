class Movie {
  final String title;
  final String image;
  final double rating;
  final String releaseDate;
  final List<String> genres;

  Movie({
    required this.title,
    required this.image,
    required this.rating,
    required this.releaseDate,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['year']?.toString() ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}

