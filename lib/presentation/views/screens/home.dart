import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:psgames/constants/strings.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';
import 'package:psgames/presentation/views/widgets/dialog_box.dart';
import 'package:psgames/presentation/views/widgets/list_item_card.dart';
import 'package:psgames/presentation/views/widgets/loading.dart';
import 'package:psgames/presentation/views/widgets/star_rating_bar.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';
import 'package:psgames/utils/device_utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GlobalViewModel _globalModel;
  late GamesViewModel _gamesViewModel;
  late ScrollController _scrollController;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _globalModel = Provider.of<GlobalViewModel>(context, listen: false);
    //////// Init network connectivity & checking...........
    _globalModel.initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_globalModel.checkNetworkConnectivity);

    //////////// Scroll controller listener .............
    _scrollController = ScrollController()..addListener(_loadNextPage);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextPage);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gamesViewModel = Provider.of<GamesViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /////// Title ..................
                Container(
                    padding: EdgeInsets.only(
                        top: DeviceUtils.getScaledHeight(context, 0.02),
                        bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                    child: TextView(
                      text: Strings.playstationGames,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                    child: Consumer<GamesViewModel>(
                        builder: (_, value, __) => (ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                value != null ? value.gamesList.length : 0,
                            itemBuilder: (context, index) {
                              /////////////// Games list Item  ..........
                              return InkWell(
                                onTap: () {
                                  _selectGameFromList(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 3,
                                    vertical: 3,
                                  ),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.spaceAround,
                                    children: [
                                      /////////// Game item with background image ..........
                                      ListItemCard(
                                        item: value.gamesList[index],
                                        index: index,
                                        onTapped: () {
                                          _selectGameFromList(index);
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: DeviceUtils.getScaledWidth(
                                            context, 0.4),
                                        child: Column(
                                          children: [
                                            /////////// Game Title ..............
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: TextView(
                                                  text: value.gamesList[index]
                                                          .name ??
                                                      '',
                                                  fontSize: 20,
                                                  maxLines: 2,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: Colors.black,
                                                )),
                                            ////////// Game Released date................
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: TextView(
                                                  text: value.gamesList[index]
                                                          .released ??
                                                      '',
                                                  fontSize: 14,
                                                  maxLines: 6,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black,
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                            ///////////// Game Rating ............
                                            StarRatingBar(
                                              rating: (value.gamesList[index]
                                                              .rating !=
                                                          null &&
                                                      value.gamesList[index]
                                                              .rating !=
                                                          0)
                                                  ? double.parse((value
                                                          .gamesList[index]
                                                          .rating)
                                                      .toString())
                                                  : 0,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))))
              ],
            ),
            ////// Next page loading UI..........
            Consumer<GamesViewModel>(
                builder: (_, value, __) => value.loadingNextPage
                    ? Positioned(
                        bottom: 0, left: 0, right: 0, child: LoadingCircle())
                    : SizedBox()),
            ///// Main Loading UI...............
            Consumer<GamesViewModel>(
                builder: (_, value, __) => value.loading
                    ? Center(child: LoadingCircle())
                    : SizedBox()),
            /////////// network connection UI..........
            Consumer<GlobalViewModel>(
                builder: (_, value, __) => !value.networkConnected!
                    ? Center(
                        child: DialogBox(
                        text: 'Oops! No network connection',
                      ))
                    : SizedBox()),
          ],
        ),
      ),
    );
  }

//////////// Select game & navigate to game details screen.................
  _selectGameFromList(int index) {
    _gamesViewModel.setSelectedGame(null);

    int? id = _gamesViewModel.gamesList[index].id;
    _gamesViewModel.setSelectedGameId(id ?? 0);
    _globalModel.setBottomNavIndex(4, currentIndex: 0);
  }

  ///////// Load next Page Game list.....................
  void _loadNextPage() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _gamesViewModel.getNextPageGamesList();
    }
  }
}
