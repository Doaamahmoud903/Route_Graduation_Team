import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart';

class FavouriteResponseDto extends FavouriteResponseEntity{
  FavouriteResponseDto({ super.message,  super.data});
  factory FavouriteResponseDto.fromJson(Map<String, dynamic> json) {
    return FavouriteResponseDto(
      message: json['message'],
      data: FavouriteMovieDto.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }

}
class FavouriteMovieDto extends FavouriteMovieEntity{
  FavouriteMovieDto({super.name ,super.imageURL ,super.movieId,super.rating ,super.year});
  factory FavouriteMovieDto.fromJson(Map<String, dynamic> json) {
    return FavouriteMovieDto(
      movieId: json['movieId'],
      name: json['name'],
      rating: (json['rating'] as num).toDouble(),
      imageURL: json['imageURL'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': name,
      'rating': rating,
      'imageURL': imageURL,
      'year': year,
    };
  }
}

class DelFavouriteResponseDto extends DelFavouriteResponseEntity{
  DelFavouriteResponseDto({ super.message,  super.data});
  factory DelFavouriteResponseDto.fromJson(Map<String, dynamic> json) {
    return DelFavouriteResponseDto(
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}