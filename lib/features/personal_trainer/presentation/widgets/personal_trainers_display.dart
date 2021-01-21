import 'package:flutter/material.dart';
import 'package:movpass_app/core/utils/nav.dart';
import 'package:movpass_app/features/personal_trainer/domain/entities/personal_trainer.dart';
import 'package:movpass_app/features/personal_trainer/presentation/widgets/personal_trainer_detail.dart';

class PersonalTrainersDisplay extends StatelessWidget {
  final List<PersonalTrainer> personalTrainers;

  const PersonalTrainersDisplay({
    Key key,
    @required this.personalTrainers,
  })  : assert(personalTrainers != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: personalTrainers.length,
      itemBuilder: (context, index) {
        final PersonalTrainer item = personalTrainers[index];
        return personalTrainerCard(context, item);
      },
    );
  }
}

Widget personalTrainerCard(BuildContext context, PersonalTrainer item) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white70,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8.0,bottom: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(item.name ?? "Não informado.", style: TextStyle(fontSize: 20, color: Colors.black)),
                        SizedBox(height: 10,),

                        Text("CREF: " + item.cref ?? "Não informado.", style: TextStyle(fontSize: 20, color: Colors.black)),

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_forward_ios),
                    ],
                  )
                ],
              ),

            ),
            Divider(
              thickness: 1.0,
            )
          ],
        ),
      ),
    ),
    onTap: (){
      push(context, PersonalTrainerDetail(idString: item.id.toString()));
    },
  );
}
