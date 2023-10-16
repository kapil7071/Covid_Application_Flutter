import 'package:covid/world_state.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  String name;
  String image;
  int totalcase,
      todaydeath,
      totalrecoverd,
      active,
      critcal,
      todayrecoverd,
      test;
  Detail(
      {super.key,
      required this.name,
      required this.totalcase,
      required this.active,
      required this.critcal,
      required this.image,
      required this.totalrecoverd,
      required this.todayrecoverd,
      required this.test,
      required this.todaydeath});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
              widget.image,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Reused(
                        title: "Total Case",
                        value: widget.totalcase.toString()),
                    Reused(
                        title: "Active Case", value: widget.active.toString()),
                    Reused(
                        title: "critcal Case",
                        value: widget.critcal.toString()),
                    Reused(
                        title: "Total Recoverd",
                        value: widget.totalrecoverd.toString()),
                    Reused(
                        title: "Today Death",
                        value: widget.todaydeath.toString())
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
