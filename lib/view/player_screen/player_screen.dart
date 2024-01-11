import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/player_controller/player_controller.dart';
import 'package:music_player/utils/constant/colors.dart';
import 'package:music_player/utils/constant/text_const.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerSCreen extends StatelessWidget {
  final SongModel data;
  const PlayerSCreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 310,
              width: 310,
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: QueryArtworkWidget(
                id: data.id,
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: Icon(
                  Icons.music_note,
                  size: 48,
                  color: whiteColor,
                ),
              ),
            )),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                children: [
                  Text(
                    // "Music name"
                    data.displayNameWOExt,
                    style: ourStyle(color: bgColor, family: bold, size: 24),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    // "Artist name"
                    data.artist.toString(),
                    style: ourStyle(color: bgColor, family: regular, size: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        "0:0",
                        style: ourStyle(color: bgDarkColor),
                      ),
                      Expanded(
                        child: Slider(
                          thumbColor: sliderColor,
                          inactiveColor: bgColor,
                          activeColor: sliderColor,
                          value: 0.0,
                          onChanged: (newValue) {},
                        ),
                      ),
                      Text(
                        "04:00",
                        style: ourStyle(color: bgDarkColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                          color: bgDarkColor,
                        ),
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor: bgDarkColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? Icon(
                                        Icons.pause,
                                        size: 54,
                                        color: whiteColor,
                                      )
                                    : Icon(
                                        Icons.play_arrow_rounded,
                                        size: 54,
                                        color: whiteColor,
                                      )),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next_rounded,
                            size: 40, color: bgDarkColor),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
