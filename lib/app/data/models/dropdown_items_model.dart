class DropdownItems {
  DropdownItemItems? dropdownItemItems;

  DropdownItems({this.dropdownItemItems});

  DropdownItems.fromJson(Map<String, dynamic> json) {
    dropdownItemItems = json['dropdown_items'] != null
        ? DropdownItemItems?.fromJson(json['dropdown_items'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (dropdownItemItems != null) {
      data['dropdown_items'] = dropdownItemItems?.toJson();
    }
    return data;
  }
}

class DropdownItemItems {
  List<String>? head;
  List<String>? tail;
  List<String>? all;

  DropdownItemItems({this.head, this.tail, this.all});

  DropdownItemItems.fromJson(Map<String, dynamic> json) {
    head = json['Head'].cast<String>();
    tail = json['Tail'].cast<String>();
    all = json['All'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Head'] = head;
    data['Tail'] = tail;
    data['All'] = all;
    return data;
  }
}





// class DropdownItems {
//   DropdownItem? dropdownItem;
//
//   DropdownItems({this.dropdownItem});
//
//   DropdownItems.fromJson(Map<String, dynamic> json) {
//     dropdownItem = json['dropdown_item'] != null
//         ? DropdownItem?.fromJson(json['dropdown_item'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     if (dropdownItem != null) {
//       data['dropdown_item'] = dropdownItem?.toJson();
//     }
//     return data;
//   }
// }
//
// class DropdownItem {
//   DropdownItem({
//     this.treg,
//     this.witel,
//     this.remarks,
//   });
//
//   List<String>? treg;
//   List<String>? witel;
//   Remarks? remarks;
//
//   factory DropdownItem.fromJson(Map<String, dynamic> json) => DropdownItem(
//     treg: List<String>.from(json["treg"].map((x) => x)),
//     witel: List<String>.from(json["witel"].map((x) => x)),
//     remarks: Remarks.fromJson(json["remarks"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "treg": List<dynamic>.from(treg!.map((x) => x)),
//     "witel": List<dynamic>.from(witel!.map((x) => x)),
//     "remarks": remarks!.toJson(),
//   };
// }
//
// class Remarks {
//   Remarks({
//     this.head,
//     this.tail,
//     this.all,
//   });
//
//   List<String>? head;
//   List<String>? tail;
//   List<String>? all;
//
//   factory Remarks.fromJson(Map<String, dynamic> json) => Remarks(
//     head: List<String>.from(json["Head"].map((x) => x)),
//     tail: List<String>.from(json["Tail"].map((x) => x)),
//     all: List<String>.from(json["All"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Head": List<dynamic>.from(head!.map((x) => x)),
//     "Tail": List<dynamic>.from(tail!.map((x) => x)),
//     "All": List<dynamic>.from(all!.map((x) => x)),
//   };
// }




////////legacy code//////////////////////////////////////////////////
// class DropdownItem {
//   List<String>? head;
//   List<String>? tail;
//   List<String>? all;
//
//   DropdownItem({this.head, this.tail, this.all});
//
//   DropdownItem.fromJson(Map<String, dynamic> json) {
//     head = json['Head'].cast<String>();
//     tail = json['Tail'].cast<String>();
//     all = json['All'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Head'] = head;
//     data['Tail'] = tail;
//     data['All'] = all;
//     return data;
//   }
// }
