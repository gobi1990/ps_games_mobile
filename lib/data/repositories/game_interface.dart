import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/domain/entities/game_single.dart';
import 'package:psgames/domain/entities/screen_shot.dart';

abstract class IGameRepository {
  Future<List<Game>> getAllGamesList(
      {int? page, int? pageLimit, String? dates});

  Future<GameSingle> getSpecificGameDetails(int id);

  Future<List<ScreenShot>> getSpecificGameScreenShots(int id);
}
