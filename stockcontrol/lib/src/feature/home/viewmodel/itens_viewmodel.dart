class Item {
  final String name;
  final int idEstabelecimento;
  final int id;

  Item(this.name, this.idEstabelecimento, this.id);

  @override
  String toString() {
    return 'Item{name: $name, id: $id, idEstabelecimento: $idEstabelecimento}';
  }
}
