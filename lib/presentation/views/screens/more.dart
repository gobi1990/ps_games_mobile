import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psgames/constants/strings.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';
import 'package:psgames/utils/device_utils.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          /////// Title ..................
          Container(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledHeight(context, 0.05),
                  bottom: DeviceUtils.getScaledHeight(context, 0.02)),
              child: TextView(
                text: Strings.more,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          _buildOptionList(),
        ],
      ),
    );
  }

  Widget _buildOptionList() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _buildTile(moreItems[index]);
        },
        separatorBuilder: (_, index) {
          return SizedBox(
            height: 15,
          );
        },
        itemCount: moreItems.length);
  }

////////// Tile list item UI ................
  Widget _buildTile(String? name) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 4),
            ]),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextView(
                  text: name ?? '',
                  fontSize: 22,
                  maxLines: 1,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
            Icon(
              Icons.arrow_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  static final moreItems = ['Profile', 'Theme', 'Logout'];
}
