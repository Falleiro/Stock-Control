class Estabelecimento {
  final int id;
  final String name;

  Estabelecimento(this.name, this.id);

  @override
  String toString() {
    return 'Estabelecimento{name: $name, id: $id}';
  }
}
