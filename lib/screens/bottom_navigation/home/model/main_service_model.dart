class MainServiceModel {
  String title;
  String iconPath;
  int id;
  Function() onTap;
  MainServiceModel({
    required this.id,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });
}
