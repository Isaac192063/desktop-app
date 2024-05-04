class Order {
  final int id;
  final String fechaRemision;
  final int cantidadEnvases;
  final String factura;
  final int total;

  const Order(
      {required this.id,
      required this.fechaRemision,
      required this.cantidadEnvases,
      required this.factura,
      required this.total});
}

const orderListItems = <Order>[
  Order(
    id: 1,
    fechaRemision: '1/12/2002',
    cantidadEnvases: 10 ,
    factura: '34454B5',
    total: 70000,
  ),
  Order(
    id: 1,
    fechaRemision: '1/12/2002',
    cantidadEnvases: 10 ,
    factura: '34454B5',
    total: 70000,
  ),
  Order(
    id: 1,
    fechaRemision: '1/12/2002',
    cantidadEnvases: 10 ,
    factura: '34454B5',
    total: 70000,
  ),
  Order(
    id: 1,
    fechaRemision: '1/12/2002',
    cantidadEnvases: 10 ,
    factura: '34454B5',
    total: 70000,
  ),
];
