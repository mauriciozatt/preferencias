/*
Esse projeto tem como  Obejetivo demostrar como podemos gravar os dados de "Preferencias" no aparelho do usuário..
OBS: Os dados so ficarão gravador enquanto o mesmo não desistalar o app,  uma vez desistalado os dados são perdidos....



 */


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _vEdit = 'Sem Valor';
  TextEditingController _ControlerEdit = TextEditingController();

  /// uso a Async pois não sei quanto tempo  pode demorar para gravar essas info...
  _Salvar() async {
    //instancio meu objeto
    final preferencias = await SharedPreferences.getInstance();
    //Método de gravar...
    await preferencias.setString("nome", _ControlerEdit.text);
    print("Salvo" + _ControlerEdit.text);
  }

  _Exibir() async {
    final preferencias = await SharedPreferences.getInstance();

    setState(() {
      _vEdit = preferencias.getString("nome").toString();
      print("retorno" + preferencias.getString("nome").toString());
    });
  }

  _Excluir() async {
    final preferencias = await SharedPreferences.getInstance();

    preferencias.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manipulação de dados")),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(_vEdit),
              )),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite Algo",
              ),
              controller: _ControlerEdit,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                      onPressed: _Salvar,
                      icon: Icon(Icons.add),
                      label: Text("Salvar")),
                  ElevatedButton.icon(
                      onPressed: _Exibir,
                      icon: Icon(Icons.get_app),
                      label: Text("Exibir")),

                  ElevatedButton.icon(
                      onPressed: _Excluir,
                      icon: Icon(Icons.delete),
                      label: Text("Excluir"))

                ],
              ))
        ],
      ),
    );
  }
}
