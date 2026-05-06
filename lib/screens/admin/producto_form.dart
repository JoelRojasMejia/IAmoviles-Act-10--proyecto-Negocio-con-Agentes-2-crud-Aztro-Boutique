import 'dart:io';
import 'package:flutter/material.dart';

import '../../models/productos_model.dart';
import '../../services/firestore_service.dart';
import '../../services/storage_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/image_picker_widget.dart';

class ProductoForm extends StatefulWidget {
  final Producto? producto;

  const ProductoForm({super.key, this.producto});

  @override
  State<ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends State<ProductoForm> {
  final service = FirestoreService();
  final storageService = StorageService();

  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final precio = TextEditingController();
  final stock = TextEditingController();
  final marca = TextEditingController();
  final color = TextEditingController();
  final talla = TextEditingController();
  final material = TextEditingController();

  File? imagenSeleccionada;
  String? imagenUrl;

  bool enOferta = false;
  double descuento = 0;
  CategoriaBoutique categoria = CategoriaBoutique.superior;

  @override
  void initState() {
    if (widget.producto != null) {
      final p = widget.producto!;

      nombre.text = p.nombre;
      descripcion.text = p.descripcion;
      precio.text = p.precio.toString();
      stock.text = p.stock.toString();
      marca.text = p.marca;
      color.text = p.color;
      talla.text = p.talla;
      material.text = p.material;
      categoria = p.categoria;
      enOferta = p.enOferta;
      descuento = p.descuentoPorcentaje ?? 0;

      if (p.imagenes.isNotEmpty) {
        imagenUrl = p.imagenes.first;
      }
    }
    super.initState();
  }

  Future<void> subirImagen() async {
    if (imagenSeleccionada != null) {
      imagenUrl = await storageService.subirImagen(imagenSeleccionada!);
    }
  }

  void guardar() async {
    await subirImagen();

    final producto = Producto(
      id: widget.producto?.id,
      sku: "SKU-${DateTime.now().millisecondsSinceEpoch}",
      nombre: nombre.text,
      descripcion: descripcion.text,
      precio: double.parse(precio.text),
      stock: int.parse(stock.text),
      marca: marca.text,
      color: color.text,
      talla: talla.text,
      material: material.text,
      categoria: categoria,
      imagenes: imagenUrl != null ? [imagenUrl!] : [],
      enOferta: enOferta,
      descuentoPorcentaje: enOferta ? descuento : null,
    );

    if (producto.id == null) {
      await service.crearProducto(producto);
    } else {
      await service.actualizarProducto(producto);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Producto")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// IMAGEN
          ImagePickerWidget(
            initialImageUrl: imagenUrl,
            onImageSelected: (file) {
              imagenSeleccionada = file;
            },
          ),

          const SizedBox(height: 20),

          CustomTextField(label: "Nombre", controller: nombre),
          CustomTextField(label: "Descripción", controller: descripcion),
          CustomTextField(label: "Precio", controller: precio, isNumber: true),
          CustomTextField(label: "Stock", controller: stock, isNumber: true),
          CustomTextField(label: "Marca", controller: marca),
          CustomTextField(label: "Color", controller: color),
          CustomTextField(label: "Talla", controller: talla),
          CustomTextField(label: "Material", controller: material),

          const SizedBox(height: 10),

          DropdownButtonFormField(
            value: categoria,
            items: CategoriaBoutique.values.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c.name),
              );
            }).toList(),
            onChanged: (v) => setState(() => categoria = v!),
          ),

          SwitchListTile(
            title: const Text("En oferta"),
            value: enOferta,
            onChanged: (v) => setState(() => enOferta = v),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: guardar,
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}