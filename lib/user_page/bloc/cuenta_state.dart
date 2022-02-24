part of 'cuenta_bloc.dart';


abstract class ListacuentaState extends Equatable {
  const ListacuentaState();
  
  @override
  List<Object> get props => [];
}

class ListaCuentaInitial extends ListacuentaState {}

class ListacuentaErrorState extends ListacuentaState {
  final String errMsg;

  ListacuentaErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class ListcuentaReady extends ListacuentaState {
  final Map listasCuentas;

  ListcuentaReady({required this.listasCuentas});

  @override
  List<Object> get props => [];
}