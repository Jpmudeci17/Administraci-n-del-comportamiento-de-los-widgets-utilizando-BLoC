part of 'cuenta_bloc.dart';

abstract class ListaCuentaEvent extends Equatable {
  const ListaCuentaEvent();

  @override
  List<Object> get props => [];
}

class LoadListaCuentas extends ListaCuentaEvent {
  
}