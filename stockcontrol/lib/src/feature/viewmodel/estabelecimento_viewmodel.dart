class Estabelecimento {
  final int id;
  final String name;
  final int cep;
  final String estado;
  final String cidade;

  Estabelecimento(
    this.id,
    this.name,
    this.cep,
    this.estado,
    this.cidade,
  );

  @override
  String toString() {
    return 'Estabelecimento{name: $name, id: $id, cep: $cep, estado: $estado, cidade: $cidade}';
  }
}
