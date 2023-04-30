import 'package:get/get.dart';

class SearchController extends SuperController{
  List<SearchItems>searchList=[];
  @override
  void onInit() {
    super.onInit();
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
    searchList.add(SearchItems("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU","HiPhone Telecom - Dubai Mall 3 Branch",
    3.3,"Al Garhoud Building Number 30,Street 65",1234567890));
  }
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
class SearchItems{
  String? title;
  double? ratingValue;
  String? address;
  int? phoneNumber;
  String? itemsImages;
  SearchItems(this.itemsImages,this.title,this.ratingValue,this.address,this.phoneNumber);
}