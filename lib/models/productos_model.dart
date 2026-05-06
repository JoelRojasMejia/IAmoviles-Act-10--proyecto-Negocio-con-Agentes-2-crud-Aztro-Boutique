enum CategoriaBoutique { superior, inferior, calzado, accesorios, vestidos }

class Producto {
  final String? id;
  final String sku;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final String marca;
  final String color;
  final String talla;
  final String material;
  final CategoriaBoutique categoria;
  final List<String> imagenes;
  final bool enOferta;
  final double? descuentoPorcentaje;

  Producto({
    this.id,
    required this.sku,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.marca,
    required this.color,
    required this.talla,
    required this.material,
    required this.categoria,
    this.imagenes = const [],
    this.enOferta = false,
    this.descuentoPorcentaje,
  });

  double get precioFinal =>
      enOferta ? precio * (1 - (descuentoPorcentaje ?? 0)) : precio;

  factory Producto.fromJson(Map<String, dynamic> json, String id) {
    return Producto(
      id: id,
      sku: json['sku'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: (json['precio'] as num).toDouble(),
      stock: json['stock'],
      marca: json['marca'],
      color: json['color'],
      talla: json['talla'],
      material: json['material'],
      categoria: CategoriaBoutique.values.byName(json['categoria']),
      imagenes: List<String>.from(json['imagenes'] ?? []),
      enOferta: json['en_oferta'] ?? false,
      descuentoPorcentaje: json['descuento_porcentaje']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'nombre': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'stock': stock,
        'marca': marca,
        'color': color,
        'talla': talla,
        'material': material,
        'categoria': categoria.name,
        'imagenes': imagenes,
        'en_oferta': enOferta,
        'descuento_porcentaje': descuentoPorcentaje,
      };
}