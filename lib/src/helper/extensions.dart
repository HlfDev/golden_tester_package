extension StringExtension on String {
  String toSnakeCase() {
    return this
        .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'),
            (Match m) => '${m[1]}_${m[2]}') // Lida com camelCase
        .replaceAllMapped(RegExp(r'([A-Z])([A-Z][a-z])'),
            (Match m) => '${m[1]}_${m[2]}') // Lida com acrônimos
        .replaceAll(' ', '_') // Substitui espaços por underscores
        .toLowerCase();
  }
}
