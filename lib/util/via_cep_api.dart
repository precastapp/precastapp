import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:precastapp/util/memory_cache.dart';

class ViaCepApi {
  var client = Client();
  var cache = MemoryCache.instance;

  Future<ViaCepResult?> find(String cep) async {
    cep = cep.numericOnly();
    if (cep.length != 8) return null;
    return cache.get(
      key: cep,
      fallback: () => _find(cep),
      duration: Duration(seconds: 120),
    );
  }

  Future<ViaCepResult> _find(String cep) async {
    var resp =
        await client.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (resp.statusCode != 200) {
      printError(info: resp.body);
      throw resp.body;
    }

    var json = jsonDecode(resp.body);
    if (json['erro'] != null) throw resp.body;

    return ViaCepResult(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
    );
  }
}

class ViaCepResult {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  ViaCepResult({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });
}
