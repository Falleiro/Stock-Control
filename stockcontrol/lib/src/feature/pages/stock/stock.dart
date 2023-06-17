import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/stock/widget/item_line.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';
import 'package:stock_control/src/feature/pages/item/item_create.dart';
import '../../../component/my_appbar.dart';
import '../../viewmodel/itens_viewmodel.dart';

class UserStock extends StatefulWidget {
  final String estabelecimento;
  final int idEstabelecimento;
  const UserStock(
      {super.key,
      required this.estabelecimento,
      required this.idEstabelecimento});

  @override
  State<UserStock> createState() => _UserStockState();
}

class _UserStockState extends State<UserStock> {
  final ItemDao _dao = ItemDao();
  final Map<int, int> _itemQuantities = {};
  rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text('appbar-item'.i18n() + widget.estabelecimento,
            style: const TextStyle(color: Colors.white, fontSize: 26)),
        elevation: 10,
      ),
      body: FutureBuilder<List<Item>>(
        initialData: const [],
        future: _dao.findAllByEstabelecimento(widget.idEstabelecimento),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircularProgressIndicator(),
                    Text('carregando'.i18n()),
                  ],
                ),
              );
            case ConnectionState.done:
              final List<Item> itens = snapshot.data ?? [];
              if (itens.isEmpty) {
                return const Center(
                  child: Text(
                    'Comece clicando em Adicionar Item',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: itens.length,
                  itemBuilder: (context, int index) {
                    final item = itens[index];
                    final int quantity = _itemQuantities[item.id] ?? item.qtd;
                    return LinhaItem(
                      idItem: item.id,
                      name: item.name,
                      qtd: quantity,
                      idEstabelecimento: widget.idEstabelecimento,
                      validade: item.validade,
                      lote: item.lote,
                      updateQuantity: (newQuantity) {
                        rebuild();
                      },
                      updateName: () {
                        rebuild();
                      },
                      refresh: () {
                        rebuild();
                      },
                    );
                  },
                );
              }
            case ConnectionState.active:
              break;
          }
          return Text('unknown-error'.i18n());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserItemCreate(
                idEstabelecimento: widget.idEstabelecimento,
              ),
            ),
          );
          setState(() {});
        },
        tooltip: 'tooltip-item'.i18n(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
