import 'package:movie_app/features/movie_details/domain/entities/all_favourites_response_entity.dart';
import 'package:movie_app/features/movie_details/data/models/favourite_response_dto.dart'; // For FavouriteMovieDto
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart'; // For FavouriteMovieEntity

/// DTO for parsing the API response that returns a LIST of favourite movies.
class AllFavouritesResponseDto extends AllFavouritesResponseEntity {
  AllFavouritesResponseDto({super.message, super.data});

  factory AllFavouritesResponseDto.fromJson(Map<String, dynamic> json) {
    return AllFavouritesResponseDto(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) {
        if (item is Map<String, dynamic>) {
          return FavouriteMovieDto.fromJson(item);
        }
        return null;
      })
          .whereType<FavouriteMovieEntity>()
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((e) => (e as FavouriteMovieDto).toJson()).toList(),
    };
  }
}