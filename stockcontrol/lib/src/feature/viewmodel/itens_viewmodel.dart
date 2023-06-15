class Item {
  final String name;
  final int idEstabelecimento;
  final int id;
  final int qtd;

  Item(this.name, this.idEstabelecimento, this.id, this.qtd);

  @override
  String toString() {
    return 'Item{name: $name, id: $id, idEstabelecimento: $idEstabelecimento, qtd: $qtd}';
  }
}
