import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psgames/constants/assets.dart';
import 'package:psgames/constants/strings.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';
import 'package:psgames/presentation/views/widgets/list_item_card.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';
import 'package:psgames/utils/device_utils.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  GlobalViewModel? _globalViewModel;
  GamesViewModel? _gamesViewModel;

  @override
  Widget build(BuildContext context) {
    _globalViewModel = Provider.of<GlobalViewModel>(context, listen: false);

    _gamesViewModel = Provider.of<GamesViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /////// Title ..................
            Container(
                padding: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, 0.02),
                    bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                child: TextView(
                  text: Strings.favourites,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            /////////// Favourites list .....
            Expanded(
              child: _buildFavouriteList(),
            ),
          ],
        ),
      ),
    );
  }

////////////// Favourite Games List UI ..........
  Widget _buildFavouriteList() {
    return Stack(
      children: [
        ///////////Gridview ............
        Container(
            child: Consumer<GamesViewModel>(
          builder: (_, value, __) => (GridView.builder(
            padding: EdgeInsets.only(
                top: 20, bottom: DeviceUtils.getScaledHeight(context, 0.02)),
            itemCount: _gamesViewModel!.favouriteGamesList.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return ListItemCard(
                item: _gamesViewModel!.favouriteGamesList[index],
                index: index,
                onTapped: () {
                  _selectFavouriteGame(index);
                },
              );
            },
          )),
        )),
        //////////// Empty list UI ...............

        Consumer<GamesViewModel>(
            builder: (_, value, __) => (Visibility(
                  visible: value.favouriteGamesList.isEmpty,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Center(
                          child: Icon(
                            Icons.warning_amber_rounded,
                            size: 80,
                            color: Colors.grey,
                          ),
                        )),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledWidth(context, 0.2),
                              vertical:
                                  DeviceUtils.getScaledHeight(context, 0.02),
                            ),
                            child: TextView(
                              text: Strings.empty_fav_list,
                              textColor: Colors.grey.withOpacity(0.9),
                              maxLines: 3,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                )))
      ],
    );
  }

  //////////// Select game & navigate to game details screen.................
  _selectFavouriteGame(int index) {
    _gamesViewModel!.setSelectedGame(null);

    int? id = _gamesViewModel!.favouriteGamesList[index].id;
    _gamesViewModel!.setSelectedGameId(id ?? 0);
    _globalViewModel!.setBottomNavIndex(4, currentIndex: 2);
  }
}
