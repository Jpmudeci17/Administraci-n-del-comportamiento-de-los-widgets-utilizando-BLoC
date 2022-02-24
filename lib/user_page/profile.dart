import 'package:banco/user_page/bloc/cuenta_bloc.dart';
import 'package:banco/user_page/bloc/picture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:feature_discovery/feature_discovery.dart';

import 'circular_button.dart';
import 'cuenta_item.dart';
import 'dart:io';


class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    ScreenshotController screenshotController = ScreenshotController();
  var featureOverflowMode = OverflowMode.clipContent;
  var featureEnablePulsingAnimation = false;

  Future compartiryCaptura() async {
    screenshotController.capture().then((image) async {
      
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image!);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
      appBar: AppBar(
        actions: [
          DescribedFeatureOverlay(
              featureId: 'feature_compartir',
              backgroundColor: Colors.lightBlue,
              contentLocation: ContentLocation.below,
              title: const Text("Boton para compartir la pantalla"),
              tapTarget: const Icon(Icons.share), targetColor: Colors.blue,
              overflowMode: OverflowMode.extendBackground,
              child:IconButton(
                tooltip: "Compartir pantalla",
                onPressed: () async {
                  await compartiryCaptura();
                
                },
                icon: Icon(Icons.share),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BlocConsumer<PictureBloc, PictureState>(
                listener: (context, state) {
                  if (state is PictureErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${state.errorMsg}")),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PictureSelectedState) {
                    return CircleAvatar(
                      backgroundImage: FileImage(state.picture),
                      minRadius: 40,
                      maxRadius: 80,
                    );
                  } else {
                    return CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 122, 113, 113),
                      minRadius: 40,
                      maxRadius: 80,
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                "Bienvenido",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(height: 8),
              Text("Usuario${UniqueKey()}"),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                DescribedFeatureOverlay(
                    featureId: 'feature_ver_tarjeta',
                    backgroundColor: Colors.lightBlue,
                    contentLocation: ContentLocation.below,
                    title: const Text("Boton para ver tarjetas"),
                    tapTarget: const Icon(Icons.camera_alt), targetColor: Color(0xff123b5e),
                    overflowMode: OverflowMode.extendBackground,
                    child:CircularButton(
                      textAction: "Ver tarjeta",
                      iconData: Icons.credit_card,
                      bgColor: Color(0xff123b5e),
                      action: null,
                    ),
                ),

                  DescribedFeatureOverlay(
                    featureId: 'feature_cambiar_foto',
                    backgroundColor: Colors.lightBlue,
                    contentLocation: ContentLocation.below,
                    title: const Text("Boton para cambiar la foto de perfil"),
                    tapTarget: const Icon(Icons.camera_alt), targetColor: Colors.orange,
                    overflowMode: OverflowMode.extendBackground,
                    child:CircularButton(
                      textAction: "Cambiar foto",
                      iconData: Icons.camera_alt,
                      bgColor: Colors.orange,
                      action: () {
                      BlocProvider.of<PictureBloc>(context).add(
                        ChangeImageEvent(),
                      );
                      },
                    ),
                  ),
                  DescribedFeatureOverlay(
                    featureId: 'feature_ver_tutorial',
                    backgroundColor: Colors.lightBlue,
                    contentLocation: ContentLocation.below,
                    title: const Text("Boton para ver el tutorial de la aplicacion"),
                    tapTarget: const Icon(Icons.play_arrow,), targetColor: Colors.green,
                    overflowMode: OverflowMode.extendBackground,
                    child:CircularButton(
                      textAction: "Ver tutorial",
                      iconData: Icons.play_arrow,
                      bgColor: Colors.green,
                      action: (){
                        FeatureDiscovery.discoverFeatures(
                          context,
                          const <String> {
                            'feature_ver_tutorial',
                            'feature_ver_tarjeta',
                            'feature_cambiar_foto',
                            'feature_compartir'
                          }
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              BlocConsumer<ListacuentaBloc, ListacuentaState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is ListcuentaReady){
                    // return Text("aaaaaaa");
                    //ListView dentro de una columna 
                    return Expanded(
                      child: ListView.builder(
                      itemCount: (state.listasCuentas["cuentas"] as List).length,
                      itemBuilder: (BuildContext context, int index) {
                        return CuentaItem(
                          tipoCuenta: state.listasCuentas["cuentas"][index]["cuenta"].toString(),
                          terminacion: (state.listasCuentas["cuentas"][index]["tarjeta"]).toString(),
                          saldoDisponible: (state.listasCuentas["cuentas"][index]["dinero"]).toString(),
                          );
                          
                      },
                                      ),
                    );
                  } else if (state is ListacuentaErrorState) {
                    return Text("No hay datos disponibles");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}