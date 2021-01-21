import 'package:flutter/material.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/presentation/widgets/modalities_display.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';

class PersonalTrainerDisplay extends StatelessWidget {
  final PersonalTrainer personalTrainer;

  const PersonalTrainerDisplay({
    Key key,
    @required this.personalTrainer,
  })  : assert(personalTrainer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Nome do Treinador'),
              subtitle: Text(personalTrainer.name ?? "Não informada"),
              leading: Icon(Icons.accessibility),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(personalTrainer.email ?? "Não informada"),
              leading: Icon(Icons.mail),
            ),
            ListTile(
              title: const Text('CREF'),
              subtitle: Text(personalTrainer.cref ?? "Não informada"),
              leading: const Icon(Icons.app_registration),
            ),
            SizedBox(height: 20,),
            Divider(thickness: 10, color: Colors.amberAccent,),
            SizedBox(height: 20,),

            Text("Modalidades", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),

            personalTrainer.modalities == null ? Container(child: Text("Sem conexão com a internet para carregar as modalidades do treinador!")) : ListView.builder(
              shrinkWrap: true,
              itemCount: personalTrainer.modalities.length,
              itemBuilder: (context, index) {
                final Modality item = personalTrainer.modalities[index];
                return modalityCard(context, item);
              },            )
          ],
        ),
      )
    );
  }
}

