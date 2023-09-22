import 'package:cep/model/enderecos_back4app_model.dart';
import 'package:cep/repository/back4app/enderecos_repo.dart';
import 'package:flutter/material.dart';

class CepsCadastrados extends StatefulWidget {
  const CepsCadastrados({super.key});

  @override
  State<CepsCadastrados> createState() => _CepsCadastradosState();
}

class _CepsCadastradosState extends State<CepsCadastrados> {
  EnderecosBack4AppRepo enderecosBack4AppRepo = EnderecosBack4AppRepo();
  var _enderecosRepo = EnderecosModel([]);

  @override
  void initState() {
    super.initState();
    get();
  }

  void get() async {
    _enderecosRepo = await enderecosBack4AppRepo.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        centerTitle: true,
      ),
      body: Column(children: [
        const Text(
          'Veja dos os Registros Pesquisados',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        TextButton(
            onPressed: () async {
              var endereco = EnderecosBack4AppRepo();
              var enderecos = await endereco.get();
              print(enderecos);
            },
            child: const Text('Teste')),
        Expanded(
            child: ListView.builder(
                itemCount: _enderecosRepo.enderecos.length,
                itemBuilder: (BuildContext bc, int index) {
                  var endereco = _enderecosRepo.enderecos[index];
                  return Card(
                    key: Key(endereco.objectId),
                    child: Text(endereco.cep),
                  );
                }))
      ]),
    ));
  }
}
