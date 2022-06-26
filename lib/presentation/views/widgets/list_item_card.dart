import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psgames/constants/assets.dart';
import 'package:psgames/domain/entities/game.dart';
import 'package:psgames/presentation/view_models/games_view_model.dart';
import 'package:psgames/presentation/view_models/global_view_model.dart';

class ListItemCard extends StatefulWidget {
  final int? index;
  final Game? item;
  final VoidCallback? onTapped;

  const ListItemCard({Key? key, this.index, this.item, this.onTapped})
      : super(key: key);

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  int cardIndex = 0;
  GamesViewModel? _gamesViewModel;
  GlobalViewModel? _globalViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardIndex = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    _globalViewModel = Provider.of<GlobalViewModel>(context, listen: false);
    _gamesViewModel = Provider.of<GamesViewModel>(
      context,
      listen: false,
    );

    return GestureDetector(
      onTap: widget.onTapped ??
          () {
            if (widget.item != null) {}
          },
      child: Container(
        width: 180,
        height: 250,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 4,
                  offset: Offset(2, 3),
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.item != null
                    ? (widget.item?.backgroundImage ??
                        Assets.image_not_available)
                    : Assets.image_not_available,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset(
                    Assets.image_not_available,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            ////// Favourite Icon button..........
            Positioned(
                child: IconButton(
              onPressed: () {
                if (widget.item != null) {
                  _gamesViewModel!.addOrRemoveFavouriteList(widget.item);
                }
              },
              icon: Icon(
                widget.item != null
                    ? (_gamesViewModel!.favouriteGameIds!
                            .contains(widget.item?.id)
                        ? Icons.favorite
                        : Icons.favorite_border)
                    : Icons.favorite_border,
                color: Colors.white,
              ),
            ))
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //         child: TextView(
            //           text: widget.title ?? '',
            //           fontSize: 22,
            //           maxLines: 2,
            //           textColor: Colors.white,
            //         )),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
