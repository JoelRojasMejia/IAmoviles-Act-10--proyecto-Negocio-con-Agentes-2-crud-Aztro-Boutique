enum RolUsuario { cliente, administrador, vendedor }

class Usuario {
  final String uid;
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
    required this.uid,
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
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  factory Usuario.fromJson(Map<String, dynamic> json, String uid) {
    return Usuario(
      uid: uid,
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
