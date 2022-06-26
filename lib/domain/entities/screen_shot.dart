import 'package:json_annotation/json_annotation.dart';

part 'screen_shot.g.dart';

@JsonSerializable()
class ScreenShot {
  final int? id;

  final String? image;

  final int? width;

  final int? height;

  ScreenShot(this.id, this.image, this.width, this.height, );

  factory ScreenShot.fromJson(Map<String, dynamic> json) =>
      _$ScreenShotFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenShotToJson(this);

  static List<ScreenShot> listFromJson(List<dynamic>? json) {
    return json == null
        ? <ScreenShot>[]
        : json.map((value) => new ScreenShot.fromJson(value)).toList();
  }
}
