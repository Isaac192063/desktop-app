class Product {
  final String quantity;
  final String id;
  final String hydrostaticDate;
  final int stock;
  final String supplier;
  final String content;
  final String typePackage;
  final int price;

  Product(
      {required this.quantity,
      required this.id,
      required this.hydrostaticDate,
      required this.stock,
      required this.supplier,
      required this.content,
      required this.typePackage,
      required this.price});

  @override
  String toString() {
    return id;
  }
}

List<Product> productListItems = [
  Product(
      id: "34556",
      hydrostaticDate: "1/04/2023",
      stock: 3,
      supplier: "RDQ",
      content: "OXIND",
      typePackage: "Verde",
      price: 70000, 
      quantity: '6.5'),
  
];
