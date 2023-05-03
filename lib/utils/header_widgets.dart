import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../utils/localisations/images_paths.dart';

class HeaderWidget extends StatefulWidget {
  final bool isBackEnabled;
  final Function(int index)? changeIndex;
  final Function() onBack;

  const HeaderWidget({
    Key? key,
    required this.isBackEnabled,
    required this.changeIndex,
    required this.onBack,
  }) : super(key: key);

  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Container(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Constants.iconSize,
                height: Constants.iconSize,
                child: widget.isBackEnabled
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          widget.onBack();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      )
                    : null),
            Image.asset(ImagesPaths.app_logo_d, width: width * .5),
            GestureDetector(
              onTap: () {
                widget.changeIndex!(9);
                // Navigator.pushNamed(context, AppRoutes.profile);
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
