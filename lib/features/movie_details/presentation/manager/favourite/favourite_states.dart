import 'package:movie_app/features/movie_details/domain/entities/favourite_response_entity.dart';

abstract class FavouriteStates{}
class FavouriteInit extends FavouriteStates{}
class FavouriteLoading extends FavouriteStates{}

class FavouriteFaliure extends FavouriteStates{
  final String errorMsg;
  FavouriteFaliure(this.errorMsg);
}

class FavouriteSuccessGeneral extends FavouriteStates{
  final FavouriteResponseEntity data;
  final bool isFav;
  FavouriteSuccessGeneral(this.data, this.isFav);
}

class FavouriteSuccessSub extends FavouriteStates{
  final DelFavouriteResponseEntity data;
  final bool isFav;
  FavouriteSuccessSub(this.data, this.isFav);
}