class BottomNavBarItemModel {
  final String itemName;
  final String routeName;
  final String navItemUnselectedImagePath;
  final String navItemSelectedImagePath;

  BottomNavBarItemModel(
      {required this.itemName,
      required this.routeName,
      required this.navItemUnselectedImagePath,
      required this.navItemSelectedImagePath});

  @override
  bool operator ==(Object other) {
    return (other is BottomNavBarItemModel && other.itemName == itemName);
  }

  @override
  int get hashCode {
    return itemName.hashCode;
  }
}

class BottomNavBarState {
  //for storing selected nav bar item
  BottomNavBarItemModel selectedNavBarItem;

  //for hiding and showing the navbar
  bool showNavBar;
  bool hideNavIndicator;

  BottomNavBarState(
      {required this.selectedNavBarItem,
      this.showNavBar = true,
      this.hideNavIndicator = false});

  //copyWith method for easy copying the old object instance into new one
  BottomNavBarState copyWith(
      {BottomNavBarItemModel? navBarItemModel,
      bool? showNavBar,
      bool? hideNavIndicator}) {
    return BottomNavBarState(
        selectedNavBarItem: navBarItemModel ?? selectedNavBarItem,
        showNavBar: showNavBar ?? this.showNavBar,
        hideNavIndicator: hideNavIndicator ?? this.hideNavIndicator);
  }
}
