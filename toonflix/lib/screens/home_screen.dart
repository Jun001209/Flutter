import 'package:flutter/material.dart';
import 'package:toonflix/models/webtton_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, future){
          if(future.hasData){
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: MakeList(future))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  ListView MakeList(AsyncSnapshot<List<WebtoonModel>> future) {
    return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: future.data!.length,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            itemBuilder: (context, index){
              var webtoon = future.data![index];
              return Webtoon(
                title: webtoon.title,
                thumb: webtoon.thumb,
                id: webtoon.id,
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 40),
          );
  }
}