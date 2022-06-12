import 'addon_model.dart';
import 'size_model.dart';

class FoodModel {
  String? description = '', id = '', name = '', image = '';
  double price = 0.0;
  List<SizeModel>? size = List<SizeModel>.empty(growable: true);
  List<AddonModel>? addon = List<AddonModel>.empty(growable: true);

  FoodModel(
      {required this.description,
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.size,
      required this.addon});

  FoodModel.fromJson(Map<String, dynamic> json) {
    // print(
    //     "******************************************print here**${json['price'].toString()}");

    id = json['id'];
    name = json['name'];
    image = json['image'];
    //price = double.parse(json['price'].toString());
    price = tranferNumberInToDouble(json['price']);
    description = json['description'];
    if (json['addon'] != null) {
      addon = List<AddonModel>.empty(growable: true);
      json['addon']?.forEach((v) {
        addon!.add(AddonModel.fromJson(v));
      });
    }
    if (json['size'] != null) {
      size = List<SizeModel>.empty(growable: true);
      json['size']?.forEach((v) {
        size!.add(SizeModel.fromJson(v));
      });
    }
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
    return data;
  }

  double tranferNumberInToDouble(var num) {
    if (num is int) {
      return double.parse(num.toString());
    }
    return num;
  }
}
