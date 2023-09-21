import 'package:flutter/material.dart';

class CepsCadastrados extends StatefulWidget {
  const CepsCadastrados({super.key});

  @override
  State<CepsCadastrados> createState() => _CepsCadastradosState();
}

class _CepsCadastradosState extends State<CepsCadastrados> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Registros'),
        centerTitle: true,
      ),
      body: Column(children: [
        Text(
          'Veja dos os Registros Pesquisados',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ]),
    ));
  }
}
