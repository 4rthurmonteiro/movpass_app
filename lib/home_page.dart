import 'package:flutter/material.dart';
import 'core/utils/nav.dart';
import 'features/modality/presentation/pages/modality_page.dart';
import 'features/personal_trainer/presentation/pages/personal_trainer_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movpass'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: RaisedButton(
                    child: Text('Treinadores'),
                    color: Theme.of(context).accentColor,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {
                      push(context, PersonalTrainerPage());
                    },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Modalidades'),
                      color: Theme.of(context).accentColor,
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () {
                        push(context, ModalityPage());
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



