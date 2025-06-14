// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data:
          json['data'] == null
              ? null
              : MovieData.fromJson(json['data'] as Map<String, dynamic>),
      meta:
          json['@meta'] == null
              ? null
              : Meta.fromJson(json['@meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
      '@meta': instance.meta,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  serverTime: (json['server_time'] as num?)?.toInt(),
  serverTimezone: json['server_timezone'] as String?,
  apiVersion: (json['api_version'] as num?)?.toInt(),
  executionTime: json['execution_time'] as String?,
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'server_time': instance.serverTime,
  'server_timezone': instance.serverTimezone,
  'api_version': instance.apiVersion,
  'execution_time': instance.executionTime,
};

MovieData _$MovieDataFromJson(Map<String, dynamic> json) => MovieData(
  movieCount: (json['movie_count'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  pageNumber: (json['page_number'] as num?)?.toInt(),
  movies:
      (json['movies'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
  'movie_count': instance.movieCount,
  'limit': instance.limit,
  'page_number': instance.pageNumber,
  'movies': instance.movies,
};

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  imdbCode: json['imdb_code'] as String?,
  title: json['title'] as String?,
  titleEnglish: json['title_english'] as String?,
  titleLong: json['title_long'] as String?,
  slug: json['slug'] as String?,
  year: (json['year'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  runtime: (json['runtime'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  summary: json['summary'] as String?,
  descriptionFull: json['description_full'] as String?,
  synopsis: json['synopsis'] as String?,
  ytTrailerCode: json['yt_trailer_code'] as String?,
  language: json['language'] as String?,
  mpaRating: json['mpa_rating'] as String?,
  backgroundImage: json['background_image'] as String?,
  backgroundImageOriginal: json['background_image_original'] as String?,
  smallCoverImage: json['small_cover_image'] as String?,
  mediumCoverImage: json['medium_cover_image'] as String?,
  largeCoverImage: json['large_cover_image'] as String?,
  state: json['state'] as String?,
  torrents:
      (json['torrents'] as List<dynamic>?)
          ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
          .toList(),
  dateUploaded: json['dateUploaded'] as String?,
  dateUploadedUnix: (json['dateUploadedUnix'] as num?)?.toInt(),
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'imdb_code': instance.imdbCode,
  'title': instance.title,
  'title_english': instance.titleEnglish,
  'title_long': instance.titleLong,
  'slug': instance.slug,
  'year': instance.year,
  'rating': instance.rating,
  'runtime': instance.runtime,
  'genres': instance.genres,
  'description_full': instance.descriptionFull,
  'yt_trailer_code': instance.ytTrailerCode,
  'language': instance.language,
  'mpa_rating': instance.mpaRating,
  'background_image': instance.backgroundImage,
  'background_image_original': instance.backgroundImageOriginal,
  'small_cover_image': instance.smallCoverImage,
  'medium_cover_image': instance.mediumCoverImage,
  'large_cover_image': instance.largeCoverImage,
  'summary': instance.summary,
  'synopsis': instance.synopsis,
  'torrents': instance.torrents,
  'dateUploaded': instance.dateUploaded,
  'dateUploadedUnix': instance.dateUploadedUnix,
  'state': instance.state,
};
