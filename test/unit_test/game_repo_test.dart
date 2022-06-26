import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psgames/data/repositories/game_interface.dart';
import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/domain/entities/game_single.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/views/screens/home.dart';

import 'game_repo_test.mocks.dart';

class GameRepoTest extends Mock implements IGameRepository {}

@GenerateMocks([GameRepoTest])
Future<void> main() async {
  late MockGameRepoTest gameRepoTest;

  setUpAll(() {
    gameRepoTest = MockGameRepoTest();
  });

///////////// Test Group - Game Repo testing ..........
  group('Game Repository Test - Get All Games List', () {
    test('test get all games List', () async {
      List<Game> gamesList = [];
      //   final gameModel = GamesViewModel();

      when(gameRepoTest.getAllGamesList(page: 1, pageLimit: 20))
          .thenAnswer((_) async {
        return gamesList;
      });

      final result = await gameRepoTest.getAllGamesList(page: 1, pageLimit: 20);

      expect(result, isA<List<Game>>());
      expect(result, gamesList);
    });

    test('Games List Exception', () async {
      when(gameRepoTest.getAllGamesList()).thenAnswer((_) async {
        throw Exception();
      });

      final result = gameRepoTest.getAllGamesList();

      expect(result, throwsException);
    });
  });

///////////// Test Group - Game Repo testing - Specific Game Details ..........
  group('Game Repository Test - Get Specific Game Details', () {
    test('test get specific game details', () async {
      final gameSingle = GameSingle(null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null, null);

      when(gameRepoTest.getSpecificGameDetails(3498)).thenAnswer((_) async {
        return gameSingle;
      });

      final result = await gameRepoTest.getSpecificGameDetails(3498);

      expect(result, isA<GameSingle>());
      expect(result, gameSingle);
    });
  });
}
