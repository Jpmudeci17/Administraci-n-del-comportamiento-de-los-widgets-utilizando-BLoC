part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();
  
  @override
  List<Object> get props => [];
}

class PictureInitial extends PictureState {}

//En caso de que hubiera un error
class PictureErrorState extends PictureState {
  final String errorMsg;

  PictureErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class PictureSelectedState extends PictureState {
  final File picture;

  PictureSelectedState({required this.picture});

  @override
  List<Object> get props => [picture];
}

