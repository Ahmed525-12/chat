import 'package:flutter/material.dart';

import '../../model/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        decoration:  BoxDecoration(
          boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: const Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  )],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
    
    
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset("assets/img/${room.catId}.png",fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width*0.2, ),
            SizedBox(height: 10,),
            Text(room.title),
          ],),
        ),
      ),
    );
  }
}
