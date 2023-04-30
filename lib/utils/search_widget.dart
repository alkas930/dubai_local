import 'package:dubai_local/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class SearchWidget extends StatefulWidget {
  final bool isLight;
  final double width;

  const SearchWidget({Key? key, required this.isLight, this.width = 0.8})
      : super(key: key);

  @override
  _SearchWidget createState() => _SearchWidget();
}

class _SearchWidget extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(blurRadius: 0.5, offset: Offset(0, 8), spreadRadius: -8)
          ]),
      width: Get.width * widget.width,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          suffixIcon: const Icon(
            Icons.search,
            color: Color(0xff626262),
          ),
          hintText: "Try 'Asian Cuisine' or 'Mobile shop'",
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xff626262)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(Constants.themeColorRed)),
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
