import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:psgames/constants/assets.dart';
import 'package:psgames/constants/font_family.dart';
import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/domain/entities/game_single.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';
import 'package:psgames/presentation/views/widgets/image_card.dart';
import 'package:psgames/presentation/views/widgets/loading.dart';
import 'package:psgames/presentation/views/widgets/star_rating_bar.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';
import 'package:psgames/utils/device_utils.dart';

class GameDetailsScreen extends StatefulWidget {
  GameDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  GamesViewModel? _gamesViewModel;
  GlobalViewModel? _globalViewModel;
  GameSingle? _selectedGame;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _gamesViewModel = Provider.of<GamesViewModel>(
      context,
    );

    _globalViewModel = Provider.of<GlobalViewModel>(
      context,
    );

    _selectedGame = _gamesViewModel?.selectedGame;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///////// Back Button.................
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              //////////// Check the previous screen and navigate back.............
                              _globalViewModel?.setBottomNavIndex(
                                  _globalViewModel?.getCurrentNavIndex() != 0
                                      ? _globalViewModel!.getCurrentNavIndex()
                                      : 0);
                            },
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                            ),
                            color: Colors.black,
                          ),
                        ),
                        ///////// Favourite Icon ..................
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              ////   _gamesViewModel!
                              //    .addOrRemoveFavouriteList(_selectedGame);
                            },
                            icon: Icon(
                              _gamesViewModel!.favouriteGameIds!
                                      .contains(_selectedGame?.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                            ),
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  //////////// Poster Image ................
                  ImageCard(
                    widthScale: 1,
                    heightScale: 0.5,
                    imageUrl: _selectedGame != null
                        ? _selectedGame!.backgroundImage
                        : Assets.image_not_available,
                  ),
                  /////// Title ..................
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextView(
                        text: _selectedGame?.name ?? '',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                        textColor: Colors.blueGrey,
                      )),
                  ////////////// Star Rating Bar ..............
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: StarRatingBar(
                      itemSize: 25,
                      rating: (_selectedGame?.rating != null &&
                              _selectedGame?.rating != 0)
                          ? double.parse((_selectedGame?.rating).toString())
                          : 0,
                    ),
                  ),
                  /////// Extra details ---- (Release , Langauge )............
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 1),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      direction: Axis.horizontal,
                      children: [
                        _buildExtraDetails(
                            'Playtime',
                            _selectedGame?.playtime != null
                                ? '${_selectedGame?.playtime.toString()} hours'
                                : '--'),
                        _buildExtraDetails('Release',
                            _selectedGame?.released.toString() ?? '--'),
                      ],
                    ),
                  ),

                  /////// Overview ..................
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Html(
                        data: _selectedGame?.description ?? '',
                        style: {
                          'body': Style(
                              fontSize: FontSize.large,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.justify,
                              color: Colors.blueGrey,
                              fontFamily: FontFamily.poppins),
                        },
                      )),
                  /////// Game description ..................
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextView(
                            text: 'Screen shots',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildScreenShotsListView(),
                  ),
                  //
                ],
              ),
            ),
            if (_gamesViewModel!.loading) Center(child: LoadingCircle()),
          ],
        ),
      ),
    );
  }

////////// Extra Details .................
  Widget _buildExtraDetails(String? title, String? subtitle) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.4),
      child: Column(
        children: [
          /////// Title ..................
          Container(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledHeight(context, 0.02),
                  bottom: DeviceUtils.getScaledHeight(context, 0.01)),
              child: TextView(
                text: title ?? '',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )), /////// Subtitle ..................
          Container(
              child: TextView(
            text: subtitle ?? '--',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.blueGrey,
          )),
        ],
      ),
    );
  }

  /////////////////// Screen shots ................
  Widget _buildScreenShotsListView() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _gamesViewModel?.screenShotsList!.length,
              itemBuilder: (BuildContext context, int index) {
                ///////// Cast member Image with gesture detector.............
                return GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ImageCard(
                      borderRadius: 8,
                      heightScale: 0.8,
                      widthScale: 1,
                      shadowBlurRadius: 20,
                      shadowSpreadRadius: 3,
                      imageUrl: _gamesViewModel?.screenShotsList![index].image,
                    ),
                  ),
                );
              }),
          Visibility(
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.black,
              ),
            ),
            visible: _gamesViewModel!.loading,
          )
        ],
      ),
    );
  }
}
