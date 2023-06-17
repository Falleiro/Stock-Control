class Item {
  final String name;
  final int idEstabelecimento;
  final int id;
  final int qtd;
  final int lote;
  final String validade;

  Item(this.name, this.idEstabelecimento, this.id, this.qtd, this.lote,
      this.validade);

  @override
  String toString() {
    return 'Item{name: $name, id: $id, idEstabelecimento: $idEstabelecimento, qtd: $qtd, validade: $validade, lote: $lote}';
  }
}
