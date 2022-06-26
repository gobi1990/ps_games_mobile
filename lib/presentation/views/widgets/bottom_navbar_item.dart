import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psgames/utils/device_utils.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';

class BottomNavBarItem extends StatelessWidget {
  final int itemIndex;
  final String? title;
  final Icon activeIcon;
  final Icon inactiveIcon;
  final int currentIndex;
  final void Function(int index) onTapAction;

  const BottomNavBarItem({
    Key? key,
    required this.itemIndex,
    this.title,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.currentIndex,
    required this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            onTapAction(itemIndex);
          },
          child: Container(
            padding: EdgeInsets.only(
              left: DeviceUtils.getScaledWidth(context, 0.01),
              right: DeviceUtils.getScaledWidth(context, 0.01),
              top: DeviceUtils.getScaledHeight(context, 0.02),
            ),
            child: Column(
              children: [
                (currentIndex == itemIndex) ? activeIcon : inactiveIcon,
                SizedBox(
                  height: 10,
                ),
                (currentIndex == itemIndex)
                    ? Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle))
                    : TextView(
                        maxLines: 1,
                        fontSize: 11,
                        text: title ?? '',
                      )
              ],
            ),
          )),
    );
  }
}
