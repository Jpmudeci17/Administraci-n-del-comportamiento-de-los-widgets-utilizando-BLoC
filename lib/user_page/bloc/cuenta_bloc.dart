import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
part 'cuenta_event.dart';
part 'cuenta_state.dart';

class ListacuentaBloc extends Bloc<ListaCuentaEvent, ListacuentaState> {
  ListacuentaBloc() : super(ListaCuentaInitial()) {
    on<ListaCuentaEvent>(loadListaCuentas);
  }
  final String url = "https://api.sheety.co/d89b0f60f5a721cba13b0538b7530c40/dummyApi/cuentas";

  void loadListaCuentas(ListaCuentaEvent event, Emitter emitter) async{
    var listasCuentas = await _getListacuentas();
    if (listasCuentas == null){
      emitter(ListacuentaErrorState(errMsg: "Muerte"));
    } else {
      emitter(ListcuentaReady(listasCuentas: listasCuentas));
    }
  }

  Future _getListacuentas() async {
    try {
      Response res = await get(Uri.parse(url));
      if(res.statusCode == HttpStatus.ok)
        return jsonDecode(res.body);
    } catch (e) {print(e);}
  }
}

