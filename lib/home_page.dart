import 'package:flutter/material.dart';

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
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height / 3,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Placeholder(fallbackHeight: 30,),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Placeholder(fallbackHeight: 30,),
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
