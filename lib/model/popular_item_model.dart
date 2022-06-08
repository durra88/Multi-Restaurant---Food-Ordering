//Best deadl & popular model
class PopularItemModel {
  // ignore: non_constant_identifier_names
  String? food_id = '', name = '', menu_id = '', image = '';
  PopularItemModel(
      // ignore: non_constant_identifier_names
      {required this.food_id,
      required this.name,
      // ignore: non_constant_identifier_names
      required this.menu_id,
      required this.image});
  PopularItemModel.fromJson(Map<String, dynamic> json) {
    food_id = json['foodId'];
    name = json['name'];
    menu_id = json['menu_id'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['foodId'] = this.food_id;
    data['name'] = this.name;
    data['menu_id'] = this.menu_id;
    data['image'] = this.image;
    return data;
  }
}
