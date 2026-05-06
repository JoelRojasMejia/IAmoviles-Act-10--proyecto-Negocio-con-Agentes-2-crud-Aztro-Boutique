# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

 

# Proyecto Final: Sistema de Gestión Boutique con Flutter & Firebase

## 1. Visión General y Estética
El objetivo es desarrollar una aplicación de administración para una **Boutique de alta gama**. El diseño debe ser minimalista, profesional y sofisticado.
* **Colores:** Paleta elegante (Negro, Blanco, Dorado, o tonos Nude/Pasteles).
* **Tipografía:** Fuentes tipo *Serif* para títulos y *Light* para cuerpo de texto.
* **Interfaz:** Limpia, con bordes redondeados y espaciado generoso para una sensación de lujo.

## 2. Requisitos Técnicos
* **Firebase:** Proyecto vinculado en Console, base de datos **Cloud Firestore** y **Firebase Auth** activo.
* **Conexión:** Incluir el archivo `google-services.json` y dependencias necesarias en `pubspec.yaml`.
* **Base:** Partir del proyecto funcional con el demo del contador.
* **Login:** Validación obligatoria con Firebase según el PDF de clase.
* **GitHub:** Enlace enviado mediante el archivo `enviargithub.dart`.

## 3. Modelos de Datos (Boutique Pro)

Deberás crear dos archivos en la carpeta `lib/models/`:

### A. Modelo de Productos (`lib/models/productos_model.dart`)
```dart
enum CategoriaBoutique { superior, inferior, calzado, accesorios, vestidos }

class Producto {
  final int? id;
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

  double get precioFinal => enOferta 
    ? precio * (1 - (descuentoPorcentaje ?? 0)) 
    : precio;

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
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
    'id': id,
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
```

### B. Modelo de Usuarios (`lib/models/usuarios_model.dart`)
```dart
enum RolUsuario { cliente, administrador, vendedor }

class Usuario {
  final int? id;
  final String nombreCompleto;
  final String email;
  final String? telefono;
  final String? direccionEnvio;
  final String? tallaReferencia; 
  final List<String> estilosFavoritos; 
  final DateTime? fechaNacimiento; 
  final RolUsuario rol;
  final DateTime fechaRegistro;
  final bool boletinActivo;

  Usuario({
    this.id,
    required this.nombreCompleto,
    required this.email,
    this.telefono,
    this.direccionEnvio,
    this.tallaReferencia,
    this.estilosFavoritos = const [],
    this.fechaNacimiento,
    this.rol = RolUsuario.cliente,
    DateTime? fechaRegistro,
    this.boletinActivo = true,
  }) : this.fechaRegistro = fechaRegistro ?? DateTime.now();

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id_usuario'],
      nombreCompleto: json['nombre_completo'],
      email: json['email'],
      telefono: json['telefono'],
      direccionEnvio: json['direccion_envio'],
      tallaReferencia: json['talla_referencia'],
      estilosFavoritos: List<String>.from(json['estilos_favoritos'] ?? []),
      fechaNacimiento: json['fecha_nacimiento'] != null 
          ? DateTime.parse(json['fecha_nacimiento']) 
          : null,
      rol: RolUsuario.values.byName(json['rol'] ?? 'cliente'),
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      boletinActivo: json['boletin_activo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_usuario': id,
    'nombre_completo': nombreCompleto,
    'email': email,
    'telefono': telefono,
    'direccion_envio': direccionEnvio,
    'talla_referencia': tallaReferencia,
    'estilos_favoritos': estilosFavoritos,
    'fecha_nacimiento': fechaNacimiento?.toIso8601String(),
    'rol': rol.name,
    'fecha_registro': fechaRegistro.toIso8601String(),
    'boletin_activo': boletinActivo,
  };
}
```

## 4. Estructura de Pantallas
1.  **Login Boutique:** Pantalla estética de ingreso.
2.  **Pantalla Inicial:** Bienvenida con botón de "Acceso al Panel".
3.  **Panel Admin (CRUD):** Gestión de la tabla de productos (Crear, Editar, Listar, Eliminar) permitiendo modificar todos los atributos de la boutique.

## 5. Entregables Finales
* **Capturas de Pantalla:** Imágenes reales de productos y diseño elegante.
* **Funcionalidad:** Proyecto totalmente operativo conectado a Firebase.
* **Código:** Subido a GitHub mediante el script solicitado.

<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/46d66e90-ee2f-4e6e-8829-0b67eb33c86c" />
<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/4f205e88-0b49-4fd8-b58b-07cc7ba83371" />
<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/e0f8c623-f6d5-4b97-a738-4beee2c5c7ad" />
<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/5279ebad-3dd3-4b79-bf90-c1c00f856d27" />
<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/30688ba1-b7d2-453f-b659-0cf50cf9faf0" />
<img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/5d495ea9-f554-4e9e-a98e-0f7002a6c322" />
