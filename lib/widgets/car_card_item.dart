import 'package:flutter/material.dart';
import '../app_constant.dart';
import '../model/car.dart';

class CarCadItem extends StatelessWidget {
  const CarCadItem({
    super.key,
    required this.filterCar,
  });

  final Car filterCar;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: appFieldColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  filterCar.imageURL,
                  height: 150,
                  width: 150,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${filterCar.make} ${filterCar.model}",style: titleTxt,),
                    Row(
                      children: [
                        InkResponse(
                            enableFeedback: true,
                            child: Image.asset("images/user_icon.png",height: 12.6,width: 14.12,)),
                        const SizedBox(width: 8.0,),
                        Text("${filterCar.seats} Seat")
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset("images/bag_icon.png",height: 12.6,width: 14.12,),
                        const SizedBox(width: 8.0,),
                        Text("${filterCar.bags} bags",style: subTxt,)
                      ],
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${filterCar.rates.hourly} /Hour",style: subTxt),
                  Text("\$${filterCar.rates.hourly} /Day",style: subTxt),
                  Text("\$${filterCar.rates.hourly} /Week",style: subTxt)
                ],
              ),
            )
          ],
        ));
  }
}