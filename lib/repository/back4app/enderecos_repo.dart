import 'package:cep/model/enderecos_back4app_model.dart';
import 'package:cep/repository/back4app/back4app_custom_dio.dart';

class EnderecosBack4AppRepo {
  final _customDio = Back4AppCustomDio();

  EnderecosBack4AppRepo();

  Future<EnderecosModel> get() async {
    var url = '/enderecos';
    var response = await _customDio.dio.get(url);
    return EnderecosModel.fromJson(response.data);
  }

  Future<void> post(EnderecoModel enderecoModel) async {
    var url = '/enderecos';
    try {
      await _customDio.dio.post(url, data: enderecoModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> put(EnderecoModel enderecoModel) async {
    var url = '/enderecos/${enderecoModel.objectId}';
    try {
      await _customDio.dio.put(url, data: enderecoModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    var url = '/enderecos/$objectId';
    try {
      await _customDio.dio.delete(url);
    } catch (e) {
      rethrow;
    }
  }
}
