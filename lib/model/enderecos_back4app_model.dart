class EnderecosModel {
  List<EnderecoModel> enderecos = [];

  EnderecosModel(this.enderecos);

  EnderecosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      enderecos = <EnderecoModel>[];
      json['results'].forEach((v) {
        enderecos.add(EnderecoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = enderecos.map((v) => v.toJson()).toList();
    return data;
  }
}

class EnderecoModel {
  String objectId = '';
  String rua = '';
  String cidade = '';
  String estado = '';
  String cep = '';
  String createdAt = '';
  String updatedAt = '';

  EnderecoModel(this.objectId, this.rua, this.cidade, this.estado, this.cep,
      this.createdAt, this.updatedAt);

  EnderecoModel.post(this.rua, this.cidade, this.estado, this.cep);

  EnderecoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    rua = json['rua'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rua'] = rua;
    data['cidade'] = cidade;
    data['estado'] = estado;
    data['cep'] = cep;
    return data;
  }
}
