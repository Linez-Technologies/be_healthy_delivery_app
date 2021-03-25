import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, int index){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: kWhiteColor,
                child: Image(image: AssetImage('${BASE_IMAGE_PATH}ic_lunch.png'),
                fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,),
              ),
              Column(
                children: [
                  Text('Order $index',
                  style: Theme.of(context).textTheme.headline6,),
                  Text('Description $index')
                ],
              ),
              Column(
                children: [
                  Text('Deliver Time'),
                  Text('3/25/2021 4:00 PM')
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
