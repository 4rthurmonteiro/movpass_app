import 'package:flutter/material.dart';
import 'package:movpass_app/core/utils/nav.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/presentation/widgets/modality_detail.dart';

class ModalitiesDisplay extends StatelessWidget {
  final List<Modality> modalities;

  const ModalitiesDisplay({
    Key key,
    this.modalities,
  })  : assert(modalities != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: modalities.length,
      itemBuilder: (context, index) {
        Modality item = modalities[index];
        return modalityCard(context, item);
      },
    );
  }
}

Widget modalityCard(BuildContext context, Modality item) {
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
                        Text(item.label, style: TextStyle(fontSize: 20, color: Colors.black)),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Duração: '),
                            Icon(Icons.access_time),
                            Text(item.duration.toString() + ' minutos'),
                          ],
                        )
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
      push(context, ModalityDetail(idString: item.id.toString()));
    },
  );
}
