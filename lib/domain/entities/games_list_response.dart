import 'package:json_annotation/json_annotation.dart';
import 'package:psgames/domain/entities/game.dart';

part 'games_list_response.g.dart';

@JsonSerializable()
class GamesListResponse {
  final int count;

  final String name;

  final String next;

  final int previous;

  final List<Game> results;

  GamesListResponse(
      this.count, this.name, this.next, this.previous, this.results);

  factory GamesListResponse.fromJson(Map<String, dynamic> json) =>
      _$GamesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GamesListResponseToJson(this);
}
