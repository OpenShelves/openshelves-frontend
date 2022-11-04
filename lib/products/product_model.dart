class Product {
  int id;
  String name;
  String asin;
  String ean;
  num? width;
  num? height;
  num? depth;
  num? weight;
  bool active;
  num? price;
  String? sku;

  String toString() {
    return 'Product: {ean: ${ean}, count: ${name}}';
  }
  // int warehouses_id;

  Product({
    required this.id,
    required this.name,
    required this.asin,
    required this.ean,
    this.depth,
    this.height,
    this.width,
    this.weight,
    required this.active,
    this.price,
    this.sku,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Product(
      id: json['id'],
      name: json['name'],
      asin: json['asin'] != null ? json['asin'] : '',
      ean: json['ean'] != null ? json['ean'] : '',
      depth: json['depth'] != null ? json['depth'] : null,
      height: json['height'] != null ? json['height'] : null,
      width: json['width'] != null ? json['width'] : null,
      weight: json['weight'] != null ? json['weight'] : null,
      active: (json['active'] != null && json['active'] == 1) ? true : false,
      price: json['price'] != null ? json['price'] : null,
      sku: json['sku'] != null ? json['sku'] : null,
    );
  }
}
