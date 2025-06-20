// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_response_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteResponseEntityAdapter
    extends TypeAdapter<FavouriteResponseEntity> {
  @override
  final int typeId = 0;

  @override
  FavouriteResponseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteResponseEntity(
      message: fields[0] as String?,
      data: fields[1] as FavouriteMovieEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteResponseEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteResponseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouriteMovieEntityAdapter extends TypeAdapter<FavouriteMovieEntity> {
  @override
  final int typeId = 1;

  @override
  FavouriteMovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteMovieEntity(
      movieId: fields[0] as String?,
      name: fields[1] as String?,
      rating: fields[2] as double?,
      imageURL: fields[3] as String?,
      year: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteMovieEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteMovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
