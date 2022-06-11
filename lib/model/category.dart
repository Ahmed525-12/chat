class Category {
  static String musicId = "music";
  static String sportId = "sports";
  static String moviesId = "movies";
  String id;
  late String image;
  late String title;
  Category(this.id, this.title, this.image);
  Category.fromId(this.id) {
    image = "assets/img/$id.png";
    title = id;
  }
  static List<Category> getCategory() {
    return
    [
      Category.fromId(musicId),
      Category.fromId(moviesId),
      Category.fromId(sportId),
    ]
    ;
  }
}
