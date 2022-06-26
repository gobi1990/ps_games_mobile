import 'package:json_annotation/json_annotation.dart';
import 'package:psgames/domain/entities/platform.dart';

part 'game_single.g.dart';

@JsonSerializable()
class GameSingle {
  final int? id;

  final String? slug;

  final String? name;

  @JsonKey(name: 'name_original')
  final String? nameOriginal;

  final String? description;

  final int? metacritic;

  final String? released;

  final bool? tba;

  @JsonKey(name: 'background_image')
  final String? backgroundImage;

  @JsonKey(name: 'background_image_additional')
  final String? backgroundImageAdditional;

  final String? website;

  final num? rating;

  @JsonKey(name: 'rating_top')
  final int? ratingTop;

  final int? playtime;

  @JsonKey(name: 'screenshots_count')
  final int? screenshotsCount;

  final List<Platform>? platforms;

  GameSingle(
      this.id,
      this.slug,
      this.name,
      this.nameOriginal,
      this.description,
      this.metacritic,
      this.released,
      this.tba,
      this.backgroundImage,
      this.backgroundImageAdditional,
      this.website,
      this.rating,
      this.ratingTop,
      this.playtime,
      this.screenshotsCount,
      this.platforms);

  factory GameSingle.fromJson(Map<String, dynamic> json) =>
      _$GameSingleFromJson(json);

  Map<String, dynamic> toJson() => _$GameSingleToJson(this);

  static List<GameSingle> listFromJson(List<dynamic>? json) {
    return json == null
        ? <GameSingle>[]
        : json.map((value) => new GameSingle.fromJson(value)).toList();
  }
}
