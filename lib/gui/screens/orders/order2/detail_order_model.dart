class DetailOrder {
  final String idOrder;
  final String idProduct;
  final String content;
  final int price;
  final String supplier;
  final String quantity;

  DetailOrder(
      {required this.quantity,
      required this.idOrder,
      required this.idProduct,
      required this.content,
      required this.price,
      required this.supplier});
}

List<DetailOrder> detailOrderListitems = [];
