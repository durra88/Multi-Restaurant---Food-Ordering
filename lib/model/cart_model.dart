import 'package:order_food/model/food_model.dart';

class CartModel extends FoodModel {
  int? quantity = 0;
  String? restaurantId = '';
  String? userUid = '';
  CartModel(
      {description,
      id,
      name,
      image,
      price,
      size,
      addon,
      required this.quantity,
      required this.restaurantId,
      required this.userUid})
      : super(
          description: description,
          id: id,
          name: name,
          image: image,
          price: price,
          size: size,
          addon: addon,
        );
  factory CartModel.fromJson(Map<String, dynamic> json) {
    final food = FoodModel.fromJson(json);
    final quantity = json['quantity'];
    final restaurantId = json['restaurantId'];
    final userUid = json['userUid'];
    return CartModel(
        description: food.description,
        id: food.id,
        name: food.name,
        image: food.image,
        price: food.price,
        size: food.size,
        addon: food.addon,
        quantity: quantity,
        restaurantId: restaurantId,
        userUid: userUid);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['size'] = this.size;
    data['description'] = this.description;
    data['size'] = this.size!.map((v) => v.toJson()).toList();
    data['addon'] = this.addon!.map((v) => v.toJson()).toList();
    data['quantity'] = this.quantity;
    data['restaurantId'] = this.restaurantId;
    data['userUid'] = this.userUid;
    return data;
  }
}
