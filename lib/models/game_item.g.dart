// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameItem _$GameItemFromJson(Map<String, dynamic> json) => GameItem(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  thumbnail: json['thumbnail'] as String?,
  shortDescription: json['short_description'] as String?,
  gameUrl: json['game_url'] as String?,
  genre: json['genre'] as String?,
  platform: json['platform'] as String?,
  publisher: json['publisher'] as String?,
  developer: json['developer'] as String?,
  releaseDate: json['release_date'] as String?,
  profileUrl: json['profile_url'] as String?,
);

Map<String, dynamic> _$GameItemToJson(GameItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'thumbnail': instance.thumbnail,
  'short_description': instance.shortDescription,
  'game_url': instance.gameUrl,
  'genre': instance.genre,
  'platform': instance.platform,
  'publisher': instance.publisher,
  'developer': instance.developer,
  'release_date': instance.releaseDate,
  'profile_url': instance.profileUrl,
};
