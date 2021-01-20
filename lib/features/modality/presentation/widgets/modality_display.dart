import 'package:flutter/material.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';

class ModalityDisplay extends StatelessWidget {
  final Modality modality;

  const ModalityDisplay({
    Key key,
    this.modality,
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
              subtitle: Text(modality.label ?? ""),
            ),
            ListTile(
              title: Text('Descrição'),
              subtitle: Text(modality.description ?? ""),
            ),
            ListTile(
              title: Text('Duração'),
              subtitle: Text(modality.duration.toString() ?? ""),
            )
          ],
        ),
      )
    );
  }
}

