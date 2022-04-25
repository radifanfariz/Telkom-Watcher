import 'dart:convert';

DropdownItemsSecond dropdownItemsSecondFromJson(String str) => DropdownItemsSecond.fromJson(json.decode(str));

String dropdownItemsSecondToJson(DropdownItemsSecond data) => json.encode(data.toJson());

class DropdownItemsSecond {
  DropdownItemsSecond({
    this.dropdownItems,
  });

  List<String>? dropdownItems;

  factory DropdownItemsSecond.fromJson(Map<String, dynamic> json) => DropdownItemsSecond(
    dropdownItems: List<String>.from(json["dropdown_items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "dropdown_items": List<dynamic>.from(dropdownItems!.map((x) => x)),
  };
}