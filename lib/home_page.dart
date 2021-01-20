import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/bloc.dart';

import 'core/utils/nav.dart';
import 'features/modality/domain/entities/modality.dart';
import 'features/modality/presentation/bloc/modality_bloc.dart';
import 'features/modality/presentation/pages/modality_page.dart';
import 'injection_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    child: Text('Personal Trainer'),
                    color: Theme.of(context).accentColor,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {

                    },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Modalidade'),
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



