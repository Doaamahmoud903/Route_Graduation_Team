import 'package:hive_flutter/hive_flutter.dart';
part 'favourite_response_entity.g.dart';

@HiveType(typeId: 0)
class FavouriteResponseEntity extends HiveObject{
  @HiveField(0)
  final String? message;
  @HiveField(1)
  final FavouriteMovieEntity? data;

  FavouriteResponseEntity({
    this.message,
    this.data,
  });
}

@HiveType(typeId: 1)
class FavouriteMovieEntity extends HiveObject{
  @HiveField(0)
  final String? movieId;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final double? rating;
  @HiveField(3)
  final String? imageURL;
  @HiveField(4)
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


