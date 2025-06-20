import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart'; // For FavouriteMovieEntity

class AllFavouritesResponseEntity {
  final String? message;
  final List<FavouriteMovieEntity>? data; // This is specifically for the list

  AllFavouritesResponseEntity({
    this.message,
    this.data,
  });
}