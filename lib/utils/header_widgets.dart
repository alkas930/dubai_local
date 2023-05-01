import 'package:dubai_local/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/localisations/images_paths.dart';

class HeaderWidget extends StatefulWidget {
  final bool isBackEnabled;

  const HeaderWidget({
    Key? key,
    required this.isBackEnabled,
  }) : super(key: key);

  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Container(
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Constants.iconSize,
                height: Constants.iconSize,
                child: widget.isBackEnabled
                    ? const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ).onTap(() {
                        Navigator.pop(context);
                      })
                    : null),
            Image.asset(ImagesPaths.app_logo_d, width: Get.width * .5),
            Container(
              width: Constants.iconSize,
              height: Constants.iconSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: ClipOval(
                child: Image.network(
                  "https://source.unsplash.com/random",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
