import 'package:json_annotation/json_annotation.dart';

part 'platform.g.dart';

@JsonSerializable()
class Platform {
  final int? id;

  final String? name;

  final String? slug;

  @JsonKey(name: 'games_count')
  final int? gamesCount;

  @JsonKey(name: 'image_background')
  final String? imageBackground;

  final String? image;

  @JsonKey(name: 'year_start')
  final int? yearStart;
  // range from 0 to 32767//

  @JsonKey(name: 'year_end')
  final int? yearEnd;
  // range from 0 to 32767//
  Platform(this.id, this.name, this.slug, this.gamesCount, this.imageBackground,
      this.image, this.yearStart, this.yearEnd);

  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformToJson(this);
}
