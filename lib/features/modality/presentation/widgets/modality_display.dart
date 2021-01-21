import 'package:flutter/material.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

class ModalityDisplay extends StatelessWidget {
  final Modality modality;

  const ModalityDisplay({
    Key key,
    @required this.modality,
  })  : assert(modality != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Tipo de treino'),
              subtitle: Text(modality.label ?? "Não informada"),
              leading: Icon(Icons.accessibility),
            ),
            ListTile(
              title: Text('Descrição'),
              subtitle: Text(modality.description ?? "Não informada"),
              leading: Icon(Icons.description),
            ),
            ListTile(
              title: const Text('Duração'),
              subtitle: Text("${modality.duration} minuto(s)" ?? "Não informada"),
              leading: const Icon(Icons.access_time),
            )
          ],
        ),
      )
    );
  }
}

