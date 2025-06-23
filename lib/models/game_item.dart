import 'package:json_annotation/json_annotation.dart';

part 'game_item.g.dart';

@JsonSerializable()
class GameItem {
  final int? id;
  final String? title;
  final String? thumbnail;
  @JsonKey(name: 'short_description')
  final String? shortDescription;
  @JsonKey(name: 'game_url')
  final String? gameUrl;
  final String? genre;
  final String? platform;
  final String? publisher;
  final String? developer;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'profile_url')
  final String? profileUrl;

  GameItem({
    this.id,
    this.title,
    this.thumbnail,
    this.shortDescription,
    this.gameUrl,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.releaseDate,
    this.profileUrl,
  });

  factory GameItem.fromJson(Map<String, dynamic> json) => _$GameItemFromJson(json);

  Map<String, dynamic> toJson() => _$GameItemToJson(this);
}