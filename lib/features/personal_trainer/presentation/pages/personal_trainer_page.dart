import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/core/widgets/loading_widget.dart';
import 'package:movpass_app/core/widgets/message_display.dart';
import 'package:movpass_app/features/personal_trainer/presentation/bloc/bloc.dart';
import 'package:movpass_app/features/personal_trainer/presentation/bloc/personal_trainer_bloc.dart';
import 'package:movpass_app/features/personal_trainer/presentation/widgets/personal_trainers_display.dart';

import '../../../../injection_container.dart';

class PersonalTrainerPage extends StatefulWidget {
  @override
  _PersonalTrainerPageState createState() => _PersonalTrainerPageState();
}

class _PersonalTrainerPageState extends State<PersonalTrainerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Treinadores'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<PersonalTrainerBloc> buildBody(BuildContext context) {
    return BlocProvider(

      builder: (_) => sl<PersonalTrainerBloc>()..dispatch(GetForAllPersonalTrainers()),
      child: BlocBuilder<PersonalTrainerBloc, PersonalTrainerState>(
          builder: (context, state) {
            if (state is Empty) {
              return const MessageDisplay(message: 'Empty');
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            } else if (state is LoadedAll) {
              return PersonalTrainersDisplay(personalTrainers: state.personalTrainers);
            }

            return Container(
              color: Colors.blue,
            );
          }),
    );
  }


}


