import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureInitial()) {
    on<ChangeImageEvent>(_onChangeImage);
  }

  void _onChangeImage(PictureEvent event, Emitter emitState) async {
    
    try{
      File? img = await _pickImage();
      if (img != null){
      emitState(PictureSelectedState(picture: img));
    } else {
      emitState(PictureErrorState(errorMsg: "No se pudo cargar la imagen"));
    }
    } catch (e){
      print(e);
    }
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final XFile? chosenFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
      );
      return chosenFile != null ? File(chosenFile.path) : null;
  }

}

  

