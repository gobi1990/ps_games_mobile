import 'package:dio/dio.dart';
import 'package:psgames/config/api_config.dart';
import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/domain/entities/game_single.dart';
import 'package:psgames/domain/entities/screen_shot.dart';

import 'package:psgames/services/http_service.dart';

import 'game_interface.dart';

class GameRepository implements IGameRepository {
  ///////// Game Repository singleton..............
  static GameRepository _gameRepository = GameRepository._();

  GameRepository._();

  static GameRepository getInstance() => _gameRepository;

/////////// Http Service Initialize................
  HttpService? _httpService = HttpService();

  ///////////////////////////
  @override
  Future<List<Game>> getAllGamesList(
      {int? page, int? pageLimit, String? dates}) async {
    Response? gamesListResponse;

    gamesListResponse = await _httpService!.getRequest(APIConfig.games_list,
        query: APIConfig.page +
            ((page != null) ? page.toString() : '') +
            '&' +
            APIConfig.page_size +
            ((pageLimit != null) ? pageLimit.toString() : '') +
            '&' +
            APIConfig.dates +
            ((dates != null) ? dates : ''));

    List<Game> _gamesList = [];
    _gamesList = Game.listFromJson(gamesListResponse!.data['results']);

    return _gamesList;
  }

  @override
  Future<GameSingle> getSpecificGameDetails(int id) async {
    Response? gameResponse;

    gameResponse = await _httpService!
        .getRequest(APIConfig.games_list + '/' + id.toString());

    return GameSingle.fromJson(gameResponse!.data);
  }

  @override
  Future<List<ScreenShot>> getSpecificGameScreenShots(int id) async {
    Response? screenShotResponse;

    screenShotResponse = await _httpService!.getRequest(APIConfig.games_list +
        '/' +
        id.toString() +
        '/' +
        APIConfig.screen_shots);

    List<ScreenShot> _screenShotsList = [];
    _screenShotsList =
        ScreenShot.listFromJson(screenShotResponse!.data['results']);

    return _screenShotsList;
  }
}
