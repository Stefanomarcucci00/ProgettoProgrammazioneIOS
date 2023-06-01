class CartProductModel {
  final String pName;
  final String pDesc;
  final String quantity;
  final String totPrice;
  final String restID;
  final String pID;

  CartProductModel({
    required this.pName,
    required this.pDesc,
    required this.quantity,
    required this.totPrice,
    required this.restID,
    required this.pID,
  });

  factory CartProductModel.fromMap(Map<dynamic, dynamic> map) {
    return CartProductModel(
      pName: map['pName'],
      pDesc: map['pDesc'],
      quantity: map['quantity'],
      totPrice: map['totPrice'],
      restID: map['restID'],
      pID: map['pID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pName': pName,
      'pDesc': pDesc,
      'quantity': quantity,
      'totPrice': totPrice,
      'restID': restID,
      'pID': pID
    };
  }
}
