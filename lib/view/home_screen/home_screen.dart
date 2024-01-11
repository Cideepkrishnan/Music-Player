import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/player_controller/player_controller.dart';
import 'package:music_player/utils/constant/colors.dart';
import 'package:music_player/utils/constant/text_const.dart';
import 'package:music_player/view/player_screen/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: whiteColor,
              ))
        ],
        leading: Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          "Beats",
          style: ourStyle(
            family: bold,
            size: 18,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioUQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No song found",
                style: ourStyle(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Obx(
                        () => ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tileColor: bgColor,
                          title: Text(
                            // "Music name",
                            snapshot.data![index].displayNameWOExt,

                            style: ourStyle(family: bold, size: 15),
                          ),
                          subtitle: Text(
                            // "Artist name",
                            "${snapshot.data![index].artist}",
                            style: ourStyle(family: regular, size: 12),
                          ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(
                              Icons.music_note,
                              color: whiteColor,
                              size: 32,
                            ),
                          ),
                          trailing: controller.playIndex == index &&
                                  controller.isPlaying.value
                              ? Icon(
                                  Icons.play_arrow,
                                  color: whiteColor,
                                  size: 26,
                                )
                              : null,
                          onTap: () {
                            // controller.playSong(snapshot.data![index].uri, index);
                            Get.to(
                                () => PlayerSCreen(
                                      data: snapshot.data![index],
                                    ),
                                transition: Transition.downToUp);
                            controller.playSong(
                                snapshot.data![index].uri, index);
                          },
                        ),
                      ));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
