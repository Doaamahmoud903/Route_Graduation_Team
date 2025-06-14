class FavouriteResponseEntity{
  final String? message;
  final FavouriteMovieEntity? data;

  FavouriteResponseEntity({
     this.message,
     this.data,
  });
}

class FavouriteMovieEntity{
  final String? movieId;
  final String? name;
  final double? rating;
  final String? imageURL;
  final String? year;

  FavouriteMovieEntity({
     this.movieId,
     this.name,
     this.rating,
     this.imageURL,
     this.year,
  });

}

class DelFavouriteResponseEntity{
  final String? message;
  final bool? data;

  DelFavouriteResponseEntity({
    this.message,
    this.data,
  });
}