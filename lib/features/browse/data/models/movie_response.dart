import 'package:json_annotation/json_annotation.dart';

import '../../../movie_details/data/models/movie_details_response.dart';
part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final String? status;
  @JsonKey(name: 'status_message') final String? statusMessage;
  final MovieData? data;
  @JsonKey(name: '@meta') final Meta? meta;

  MovieResponse({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'server_time') final int? serverTime;
  @JsonKey(name: 'server_timezone') final String? serverTimezone;
  @JsonKey(name: 'api_version') final int? apiVersion;
  @JsonKey(name: 'execution_time') final String? executionTime;

  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  factory Meta.fromJson(Map<String, dynamic> json) =>
      _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class MovieData {
  @JsonKey(name: 'movie_count') final int? movieCount;
  final int? limit;
  @JsonKey(name: 'page_number') final int? pageNumber;
  final List<Movie>? movies;

  MovieData({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);
}

@JsonSerializable()
class Movie {
  final int? id;
  final String? url;
  @JsonKey(name: 'imdb_code') final String? imdbCode;
  final String? title;
  @JsonKey(name: 'title_english') final String? titleEnglish;
  @JsonKey(name: 'title_long') final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  @JsonKey(name: 'description_full') final String? descriptionFull;
  @JsonKey(name: 'yt_trailer_code') final String? ytTrailerCode;
  final String? language;
  @JsonKey(name: 'mpa_rating') final String? mpaRating;
  @JsonKey(name: 'background_image') final String? backgroundImage;
  @JsonKey(name: 'background_image_original') final String? backgroundImageOriginal;
  @JsonKey(name: 'small_cover_image') final String? smallCoverImage;
  @JsonKey(name: 'medium_cover_image') final String? mediumCoverImage;
  @JsonKey(name: 'large_cover_image') final String? largeCoverImage;
  final String? summary;
  final String? synopsis;
  final List<Torrent>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;
  final String? state;


  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

