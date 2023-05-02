import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/my_profile_controllers.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/header_widgets.dart';
import '../utils/localisations/images_paths.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProfileControllers controller = Get.find();
    return Column(
      children: [
        const HeaderWidget(isBackEnabled: true).px(10),
        const Text("My Profile",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400)),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://source.unsplash.com/random",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Imran Hijbul",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColorGrey,
                                decoration: TextDecoration.underline),
                          )
                        ],
                      )
                    ],
                  ),
                  profileItems(title: "My Profile", icon: ImagesPaths.ic_star),
                  const Divider(),
                  profileItems(
                      title: "My Listings", icon: ImagesPaths.ic_listings),
                  const Divider(),
                  profileItems(title: "Favourites", icon: ImagesPaths.ic_star),
                  const Divider(),
                  profileItems(
                      title: "My Membership", icon: ImagesPaths.ic_star),
                  const Divider(),
                  profileItems(title: "Payments", icon: ImagesPaths.ic_payment),
                  const Divider(),
                  profileItems(
                      title: "My Documents", icon: ImagesPaths.ic_document),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenTheme),
                        child: Row(
                          children: const [
                            Text(
                              " Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ).py(5).px(15),
                      ).onTap(() {
                        // controllers.onTapSendEnquiry();
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(Constants.themeColorRed)),
                        child: Row(
                          children: const [
                            Text(
                              "Delete Account",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ).py(5).px(15),
                      ).onTap(() {
                        // controllers.onTapSendEnquiry();
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileItems({
    required String title,
    required String icon,
  }) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 8),
      child: SizedBox(
        width: Get.width * .94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(
                    icon,
                    width: 18,
                    height: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(ImagesPaths.ic_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
