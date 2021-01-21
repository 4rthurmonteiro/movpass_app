import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/features/personal_trainer/domain/usecases/get_personal_trainer_by_id.dart';
import 'package:movpass_app/features/personal_trainer/presentation/bloc/bloc.dart';
import 'package:movpass_app/features/personal_trainer/presentation/bloc/personal_trainer_bloc.dart';
import 'package:movpass_app/features/personal_trainer/presentation/widgets/personal_trainer_display.dart';

import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display.dart';


class PersonalTrainerDetail extends StatefulWidget {
  final String idString;

  const PersonalTrainerDetail({Key key, @required this.idString}) : super(key: key);
  @override
  _PersonalTrainerDetailState createState() => _PersonalTrainerDetailState();
}

class _PersonalTrainerDetailState extends State<PersonalTrainerDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Treinador'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<PersonalTrainerBloc> buildBody(BuildContext context) {
    return BlocProvider(

      builder: (_) => sl<PersonalTrainerBloc>()..dispatch(GetPersonalTrainerForId(widget.idString)),
      child: BlocBuilder<PersonalTrainerBloc, PersonalTrainerState>(
          builder: (context, state) {
            if (state is Empty) {
              return const MessageDisplay(message:'Empty');
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            } else if (state is Loaded) {
              return PersonalTrainerDisplay(personalTrainer: state.personalTrainer,);
            }


            return Container(
              color: Colors.blue,
            );
          }),
    );
  }


}