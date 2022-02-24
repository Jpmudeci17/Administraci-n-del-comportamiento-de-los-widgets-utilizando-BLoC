part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

class ChangeImageEvent extends PictureEvent {
  //Si hubiera parametros los pondriamos aqui
}
