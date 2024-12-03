//model for parent item in drawer menu
//model for child menu item
class DrawerChildMenuItemModel {
  final String name;
  bool isSelected;
  final String imagePath;
  final dynamic extraParams;
  final Map<String, dynamic>? queryParams;
  final String routePath;
  final bool isEnabled;

  DrawerChildMenuItemModel({
    required this.name,
    this.isSelected = false,
    required this.routePath,
    required this.imagePath,
    this.isEnabled = true,
    this.extraParams,
    this.queryParams,
  });
}

class DrawerMenuItemModel {
  final String name;
  bool isSelected;
  final String? imagePath;
  final List<DrawerChildMenuItemModel> childMenuList;
  final dynamic extraParams;
  final Map<String, dynamic>? queryParams;
  String? routePath;

  DrawerMenuItemModel(
      {required this.name,
      required this.childMenuList,
      this.imagePath,
      this.isSelected = false,
      this.extraParams,
      this.queryParams,
      this.routePath});
}
