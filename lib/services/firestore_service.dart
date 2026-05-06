import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/productos_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> crearProducto(Producto p) async {
    await _db.collection('productos').add(p.toJson());
  }

  Stream<List<Producto>> getProductos() {
    return _db.collection('productos').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Producto.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> actualizarProducto(Producto p) async {
    await _db.collection('productos').doc(p.id).update(p.toJson());
  }

  Future<void> eliminarProducto(String id) async {
    await _db.collection('productos').doc(id).delete();
  }
}