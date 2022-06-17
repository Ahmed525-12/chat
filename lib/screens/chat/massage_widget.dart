import 'package:chat/model/message.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MassageWidget extends StatelessWidget {
  Massage massage;
  MassageWidget(this.massage, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.user!.id == massage.senderid
        ? SendMassage(massage)
        : RecivedMassage(massage);
  }
}

class SendMassage extends StatelessWidget {
  Massage massage;
  SendMassage(this.massage, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(massage.senderName),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: Colors.blue,
              ),
              child: Text(
                massage.content,
                style: const TextStyle(color: Colors.white),
              )),
          // Text(massage.dateTime.toString()),
        
        ],
      ),
    );
  }
}

class RecivedMassage extends StatelessWidget {
  Massage massage;

  RecivedMassage(this.massage, {Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(massage.senderName),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: Text(
              massage.content,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Text(" ")
        ],
      ),
    );
  }
}
