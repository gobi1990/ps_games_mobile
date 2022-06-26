import 'package:json_annotation/json_annotation.dart';
import 'package:psgames/domain/entities/platform.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final int? id;

  final String? slug;

  final String? name;

  final String? released;

  final String? description;

  final bool? tba;

  @JsonKey(name: 'background_image')
  final String? backgroundImage;

  final num? rating;

  @JsonKey(name: 'rating_top')
  final int? ratingTop;

  //final Object ratings;
  @JsonKey(name: 'ratings_count')
  final int? ratingsCount;

  @JsonKey(name: 'reviews_text_count')
  final int? reviewsTextCount;

  final int? added;

  @JsonKey(name: 'added_by_status')
  final Object? addedByStatus;

  final int? metacritic;

/* in hours */
  final int? playtime;

  @JsonKey(name: 'suggestions_count')
  final int? suggestionsCount;

  final String? updated;

  @JsonKey(name: 'esrb_rating')
  final Object? esrbRating;

  final List<Platform>? platforms;

  Game(
      this.id,
      this.slug,
      this.name,
      this.released,
      this.tba,
      this.backgroundImage,
      this.rating,
      this.ratingTop,
      this.ratingsCount,
      this.reviewsTextCount,
      this.added,
      this.addedByStatus,
      this.metacritic,
      this.playtime,
      this.suggestionsCount,
      this.updated,
      this.esrbRating,
      this.platforms,
      this.description);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  static List<Game> listFromJson(List<dynamic>? json) {
    return json == null
        ? <Game>[]
        : json.map((value) => new Game.fromJson(value)).toList();
  }
}
