import 'package:cep/model/enderecos_back4app_model.dart';
import 'package:cep/model/via_cep_model.dart';
import 'package:cep/pages/end_cadastrados.dart';
import 'package:cep/repository/back4app/enderecos_repo.dart';
import 'package:cep/repository/via_cep_repo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  var viaCepModel = ViaCepModel();
  var viaCepRepo = ViaCepRepo();
  EnderecosBack4AppRepo enderecosRepo = EnderecosBack4AppRepo();
  var _enderecosRepo = EnderecosModel([]);

  var controllerCep = TextEditingController(text: '');

  bool loading = false;

  @override
  void initState() {
    super.initState();
    get();
  }

  void get() async {
    _enderecosRepo = await enderecosRepo.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Busca CEP'),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Text(
                      'Dìgite o CEP',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      controller: controllerCep,
                      onChanged: (String value) async {
                        var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                        if (cep.length == 8) {
                          setState(() {
                            loading = true;
                          });
                          viaCepModel = await viaCepRepo.consultarCEP(cep);
                          if (viaCepModel.ddd != null) {
                            try {
                              bool existe = _enderecosRepo.enderecos
                                  .any((endereco) => endereco.cep == cep);
                              if (!existe) {
                                await enderecosRepo.post(EnderecoModel.post(
                                    viaCepModel.logradouro ?? '',
                                    viaCepModel.localidade ?? '',
                                    viaCepModel.uf ?? '',
                                    cep));
                                const Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    child: Text(
                                      'Não encontrado.\nPortanto acaba de ser adicionado ao Banco de Dados',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                );
                              } else {
                                print('Endereço já cadastrado!');
                                const Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    child: Text(
                                      'Presente no Banco de Dados',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Deu certo não');
                            }
                          } else {
                            print('CEP não encontrado');
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                    )
                  ],
                ),
              )),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                Text(viaCepModel.logradouro ?? ''),
                Text(viaCepModel.localidade ?? ''),
                Text(viaCepModel.uf ?? ''),
                Visibility(
                    visible: loading, child: const CircularProgressIndicator())
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CepsCadastrados()));
              },
              child: Text('Ver Registros'))
        ]),
      ),
    );
  }
}
