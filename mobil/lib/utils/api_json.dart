/// PHP api.php PascalCase alan adları ↔ mobil modeller.
class ApiJson {
  static int intVal(Map<String, dynamic> j, String camel, String pascal) {
    final v = j[camel] ?? j[pascal];
    if (v is int) return v;
    if (v is String) return int.parse(v);
    return (v as num).toInt();
  }

  static String str(Map<String, dynamic> j, String camel, String pascal) {
    return (j[camel] ?? j[pascal]).toString();
  }

  static double doubleVal(Map<String, dynamic> j, String camel, String pascal) {
    final v = j[camel] ?? j[pascal];
    return (v as num).toDouble();
  }
}
