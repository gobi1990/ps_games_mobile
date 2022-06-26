import 'package:flutter/widgets.dart';
import 'package:psgames/data/repositories/game_repository.dart';
import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/domain/entities/game_single.dart';
import 'package:psgames/domain/entities/screen_shot.dart';

class GamesViewModel with ChangeNotifier {
  final _gameRepository = GameRepository.getInstance();

////////// constructor..............
  GamesViewModel() {
    getAllGamesList();
  }

/////////////// private list ................
  List<Game> _gamesList = [];

  List<Game> _searchGamesList = [];

  List<Game> _favoriteGamesList = [];

  bool _loading = false;

  GameSingle? _selectedGame;

  int? _selectedGameId;

  bool _loadingNextPage = false;

  int pageIndex = 1;

  int pageLimit = 20;

  //////////// getters................
  bool get loading => _loading;

  bool get loadingNextPage => _loadingNextPage;

  List<Game> get gamesList => _gamesList;

  List<Game> get searchedGamesList => _searchGamesList;

  List<Game> get favouriteGamesList => _favoriteGamesList;

  GameSingle? get selectedGame => _selectedGame;

  int? get selectedGameId => _selectedGameId;

  List<ScreenShot>? screenShotsList = [];

  List<int>? favouriteGameIds = [];

  ///////////// Setters ....................

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setNextPageLoading(bool value) {
    _loadingNextPage = value;
    notifyListeners();
  }

  setGamesList(List<Game> value) {
    _gamesList = value;
  }

  setSearchedGamesList(List<Game> value) {
    _searchGamesList = value;
  }

  setFavoriteGamesList(List<Game> value) {
    _favoriteGamesList = value;
  }

  setSelectedGame(GameSingle? game) {
    _selectedGame = game;
  }

  setSelectedGameId(int id) {
    _selectedGameId = id;

    getSpecificGameDetails(id);
  }

  appendGamesList(List<Game> value) {
    for (var item in value) {
      _gamesList.add(item);
    }
  }

  //////////// Get all Games from Game Repository ...............
  getAllGamesList() async {
    setLoading(true);
    var response = await _gameRepository.getAllGamesList(
        page: pageIndex, pageLimit: pageLimit);

    if (response != null) {
      setGamesList(response);
    }

    setLoading(false);
  }

  //////////// Get Next page games ...............
  getNextPageGamesList() async {
    setNextPageLoading(true);

    pageIndex++;

    var response = await _gameRepository.getAllGamesList(
        page: pageIndex, pageLimit: pageLimit);

    if (response != null) {
      appendGamesList(response);
    }

    setNextPageLoading(false);
  }

  ///////
  //////////// Get all Games from Game Repository ...............
  getSpecificGameDetails(int id) async {
    setLoading(true);
    var response = await _gameRepository.getSpecificGameDetails(id);
    screenShotsList = [];
    getGameScreenShots(id);

    if (response != null) {
      setSelectedGame(response);
    }

    setLoading(false);
  }

  getGameScreenShots(int id) async {
    var response = await _gameRepository.getSpecificGameScreenShots(id);

    if (response != null) {
      screenShotsList = response;
    }

    notifyListeners();
  }

  //////////// Add or remove game to the favourites list ...............
  addOrRemoveFavouriteList(Game? item) {
    int? id = item?.id;

    if (favouriteGameIds!.contains(id)) {
      favouriteGameIds!.remove(id);
      favouriteGamesList.remove(item);
    } else {
      favouriteGameIds!.add(id!);
      favouriteGamesList.add(item!);
    }

    notifyListeners();
  }
}
