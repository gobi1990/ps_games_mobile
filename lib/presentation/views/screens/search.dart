import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';
import 'package:psgames/presentation/views/widgets/list_item_card.dart';
import 'package:psgames/utils/device_utils.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _seachController = TextEditingController();
  GamesViewModel? _gamesViewModel;
  GlobalViewModel? _globalViewModel;

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
    _globalViewModel = Provider.of<GlobalViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /////////// Search Text field ................
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: Offset(2, 3),
                              color: Colors.black.withOpacity(0.1))
                        ]),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          width: DeviceUtils.getScaledWidth(context, 0.7),
                          child: TextFormField(
                            onChanged: (query) {},
                            controller: _seachController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: ' Search a game...'),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: IconButton(
                                onPressed: () {
                                  //////// Hide Keyboard ..................
                                  DeviceUtils.hideKeyboard(context);
                                },
                                icon: Icon(Icons.search)))
                      ],
                    )),
              ],
            ),
            Expanded(
                child: GridView.builder(
              padding: EdgeInsets.only(
                  top: 20, bottom: DeviceUtils.getScaledHeight(context, 0.02)),
              itemCount: _gamesViewModel!.gamesList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return ListItemCard(
                  item: _gamesViewModel!.gamesList[index],
                  index: index,
                  onTapped: () {
                    _selectSearchedGame(index);
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  //////////// Select game & navigate to game details screen.................
  _selectSearchedGame(int index) {
    _gamesViewModel!.setSelectedGame(null);
    

    int? id = _gamesViewModel!.gamesList[index].id;
    _gamesViewModel!.setSelectedGameId(id ?? 0);
    _globalViewModel!.setBottomNavIndex(4, currentIndex: 1);
  }
}
