/// A placeholder class that represents an entity or model.
class SampleItem {
  const SampleItem({required this.id, required this.manufacturer, required this.model, required this.color});

  final String id;
  final String manufacturer;
  final String model;
  final String color;

  factory SampleItem.fromJson(Map<String, dynamic> json) => 
  SampleItem(id: json["id"], manufacturer: json["manufacturer"], model: json["model"], color: json["color"]);
}
