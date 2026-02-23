import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

//region HomePage (edit new song)
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  String result = "";
  List<String> Lfiles = [];
  loadAssetFile(BuildContext context) async {
    List<String> listAssetsFile = [];
    //用 AssetManifest.json 來取得檔案的位置
    //AssetManifest.json是管Assets區域的檔案
    var assetsFile =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetsFile);

    //region 原神 清單

    List<String> listGenshinImg = manifestMap.keys
        .where((String key) => key.contains('assets/images/Genshin'))
        .toList();

    List<String> listGenshinMusic = manifestMap.keys
        .where((String key) => key.contains('assets/mp3/Genshin'))
        .toList();

    List<String> listGenshinLyric = manifestMap.keys
        .where((String key) => key.contains('assets/lyrics/Genshin'))
        .toList();
    //endregion
    //region MementoMori 清單
    List<String> listMmImg = manifestMap.keys
        .where((String key) => key.contains('assets/images/MementoMori'))
        .toList();

    List<String> listMmMusic = manifestMap.keys
        .where((String key) => key.contains('assets/mp3/MementoMori'))
        .toList();

    List<String> listMmLyric = manifestMap.keys
        .where((String key) => key.contains('assets/lyrics/MementoMori'))
        .toList();
    //endregion

    //region StarRail 清單
    List<String> listSrImg = manifestMap.keys
        .where((String key) => key.contains('assets/images/StarRail'))
        .toList();

    List<String> listSrMusic = manifestMap.keys
        .where((String key) => key.contains('assets/mp3/StarRail'))
        .toList();

    List<String> listSrLyric = manifestMap.keys
        .where((String key) => key.contains('assets/lyrics/StarRail'))
        .toList();
    //endregion
    //region 其他 清單
    List<String> listOtherImg = manifestMap.keys
        .where((String key) => key.contains('assets/images/Other'))
        .toList();

    List<String> listOtherMusic = manifestMap.keys
        .where((String key) => key.contains('assets/mp3/Other'))
        .toList();

    List<String> listOtherLyric = manifestMap.keys
        .where((String key) => key.contains('assets/lyrics/Other'))
        .toList();
    //endregion
    //region原神的Image&音樂位置

    for (String gImg in listGenshinImg) {
      listAssetsFile.add(gImg);
    }

    for (String gMusic in listGenshinMusic) {
      listAssetsFile.add(gMusic);
    }

    for (String gLyric in listGenshinLyric) {
      listAssetsFile.add(gLyric);
    }
    //endregion
    //region memento mori的Image&音樂位置
    for (String mImg in listMmImg) {
      listAssetsFile.add(mImg);
    }

    for (String mMusic in listMmMusic) {
      listAssetsFile.add(mMusic);
    }

    for (String mLyric in listMmLyric) {
      listAssetsFile.add(mLyric);
    }
    //endregion

    //region StarRail的Image&音樂位置
    for (String srImg in listSrImg) {
      listAssetsFile.add(srImg);
    }

    for (String srMusic in listSrMusic) {
      listAssetsFile.add(srMusic);
    }

    for (String srLyric in listSrLyric) {
      listAssetsFile.add(srLyric);
    }
    //endregion
    //region Other的Image&音樂位置
    for (String oImg in listOtherImg) {
      listAssetsFile.add(oImg);
    }

    for (String oMusic in listOtherMusic) {
      listAssetsFile.add(oMusic);
    }

    for (String oLyric in listOtherLyric) {
      listAssetsFile.add(oLyric);
    }
    //endregion
    setState(() {
      Lfiles = listAssetsFile;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadAssetFile(context);
    super.initState();
  }

  String whichCat = '請從類別選音樂';
  List<String> whichImg = ['assets/images/Other/BGM.jpg'];
  List<String> whichImgName = ['BGM'];
  List<String> whichSrcMusic = ['mp3/Other/BGM.mp3'];
  List<String> whichLyric = ['assets/lyrics/Other/BGM.txt'];

  @override
  Widget build(BuildContext context) {
    //G=原神/M=Memento Mori/O=Other/Sr=StarRail

    List<String> tryTImg =
        Lfiles.where((String key) => key.contains('assets/mp3')).toList();
    List<String> tyFilter = [];
    List<String> ab = [];
    List<String> ac = [];
    for (String filter in tryTImg) {
      String aa = filter.substring(11);
      ab = aa.split('/');
      ac.add(ab[0]);
    }
    tyFilter = ac.toSet().toList();
    //取出檔案中包含原神圖片的所有位置
    List<String> genshinImg =
        Lfiles.where((String key) => key.contains('assets/images/Genshin'))
            .toList();
    //取出檔案中包含原神音樂的所有位置
    List<String> genshinMusic =
        Lfiles.where((String key) => key.contains('assets/mp3/Genshin'))
            .toList();

    List<String> genshinLyric =
        Lfiles.where((String key) => key.contains('assets/lyrics/Genshin'))
            .toList();

    List<String> mMImg =
        Lfiles.where((String key) => key.contains('assets/images/MementoMori'))
            .toList();

    List<String> mMMusic =
        Lfiles.where((String key) => key.contains('assets/mp3/MementoMori'))
            .toList();

    List<String> mMLyric =
        Lfiles.where((String key) => key.contains('assets/lyrics/MementoMori'))
            .toList();

    List<String> srImg =
        Lfiles.where((String key) => key.contains('assets/images/StarRail'))
            .toList();

    List<String> srMusic =
        Lfiles.where((String key) => key.contains('assets/mp3/StarRail'))
            .toList();

    List<String> srLyric =
        Lfiles.where((String key) => key.contains('assets/lyrics/StarRail'))
            .toList();

    List<String> oImg =
        Lfiles.where((String key) => key.contains('assets/images/Other'))
            .toList();

    List<String> oMusic =
        Lfiles.where((String key) => key.contains('assets/mp3/Other')).toList();

    List<String> oLyric =
        Lfiles.where((String key) => key.contains('assets/lyrics/Other'))
            .toList();

    //eg.  Ganyu/mp3
    List<String> srcGMusic = [];
    for (String spGMusic in genshinMusic) {
      String spGeMusic = spGMusic.substring(7);
      srcGMusic.add(spGeMusic);
    }

    //從檔案位置中取出歌名
    List<String> imgGName = [];
    for (String spGImg in genshinImg) {
      List<String> spGeImg = spGImg.split('/');
      List<String> sGDotImg = spGeImg[3].split('.');
      imgGName.add(sGDotImg[0]);
    }

    List<String> srcMMusic = [];
    for (String spMMusic in mMMusic) {
      String spMmMusic = spMMusic.substring(7);
      srcMMusic.add(spMmMusic);
    }

    List<String> imgMName = [];
    for (String spMImg in mMImg) {
      List<String> spMmImg = spMImg.split('/');
      List<String> sMDotImg = spMmImg[3].split('.');
      imgMName.add(sMDotImg[0]);
    }

    List<String> srcSrMusic = [];
    for (String spSrMusic in srMusic) {
      String spSraMusic = spSrMusic.substring(7);
      srcSrMusic.add(spSraMusic);
    }

    List<String> imgSrName = [];
    for (String spSrImg in srImg) {
      List<String> spSraImg = spSrImg.split('/');
      List<String> sSrDotImg = spSraImg[3].split('.');
      imgSrName.add(sSrDotImg[0]);
    }

    List<String> srcOMusic = [];
    for (String spOMusic in oMusic) {
      String spOtMusic = spOMusic.substring(7);
      srcOMusic.add(spOtMusic);
    }

    List<String> imgOName = [];
    for (String spOImg in oImg) {
      List<String> spOtImg = spOImg.split('/');
      List<String> sODotImg = spOtImg[3].split('.');
      imgOName.add(sODotImg[0]);
    }

    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
            itemCount: tyFilter.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tyFilter[index]),
                onTap: () {
                  setState(() {
                    switch (index) {
                      case 0:
                        whichCat = '原神';
                        whichImg = genshinImg;
                        whichImgName = imgGName;
                        whichSrcMusic = srcGMusic;
                        whichLyric = genshinLyric;
                        Navigator.pop(context);
                        break;
                      case 1:
                        whichCat = 'Memento Mori';
                        whichImg = mMImg;
                        whichImgName = imgMName;
                        whichSrcMusic = srcMMusic;
                        whichLyric = mMLyric;
                        Navigator.pop(context);
                        break;
                      case 2:
                        whichCat = 'Star Rail';
                        whichImg = srImg;
                        whichImgName = imgSrName;
                        whichSrcMusic = srcSrMusic;
                        whichLyric = srLyric;
                        Navigator.pop(context);
                        break;
                      case 3:
                        whichCat = 'Other';
                        whichImg = oImg;
                        whichImgName = imgOName;
                        whichSrcMusic = srcOMusic;
                        whichLyric = oLyric;
                        Navigator.pop(context);
                        break;
                    }
                  });
                },
              );
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 20,
        title: Text('歌曲名單'),
      ),
      body: ListView(shrinkWrap: true, children: [
        //region 原神部分
        ExpansionTile(
          title: Text(whichCat),
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: whichImg.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      String responce = await rootBundle
                          .loadString(whichLyric[index].toString());
                      result = responce;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Song(
                                    imgLocation: whichImg[index].toString(),
                                    songName: whichImgName[index].toString(),
                                    lyricLocation: whichLyric[index].toString(),
                                    singer: whichImgName[index].toString(),
                                    songLocation:
                                        whichSrcMusic[index].toString(),
                                    category: whichCat,
                                    songList: whichImgName,
                                    imgList: whichImg,
                                    srcMusicList: whichSrcMusic,
                                    lyricList: whichLyric,
                                    lyric: result,
                                  )));
                    },
                    title: Text(whichImgName[index].toString()),
                    leading: Image.asset(
                      whichImg[index],
                      width: 100,
                      height: 100,
                    ),
                  );
                })
          ],
        ),
        //endregion
      ]),
    );
  }
}

//endregion

//region Audioplayer Page
var opacitySet = 1.0; //設定背景圖的透明度
String showLyrics = ''; //顯示歌詞

class Song extends StatefulWidget {
  String imgLocation,
      songName,
      singer,
      songLocation,
      lyricLocation,
      category,
      lyric;
  List<String> songList, imgList, srcMusicList, lyricList;
  Song(
      {required this.imgLocation,
      required this.songName,
      required this.lyricLocation,
      required this.singer,
      required this.songLocation,
      required this.category,
      required this.songList,
      required this.imgList,
      required this.srcMusicList,
      required this.lyricList,
      required this.lyric});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Song();
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}

class _Song extends State<Song> {
  bool isPlay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.pause();
    showLyrics='';
    opacitySet=1.0;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlay = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
            itemCount: widget.songList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.songList[index].toString()),
                trailing: Image.asset(
                  widget.imgList[index],
                  width: 50,
                  height: 50,
                ),
                onTap: () {
                  setState(() async {
                    widget.imgLocation = widget.imgList[index].toString();
                    widget.songName = widget.songList[index].toString();
                    widget.songLocation = widget.srcMusicList[index].toString();
                    widget.lyric = await rootBundle
                        .loadString(widget.lyricList[index].toString());
                    audioPlayer.stop();
                    showLyrics = '';
                    opacitySet = 1.0;
                    Navigator.pop(context);
                  });
                },
              );
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 30,
        title: Text(widget.songName),
        actions: [
          TextButton(
              onPressed: () {
                if (showLyrics == '') {
                  opacitySet = 0.3;
                  showLyrics = widget.lyric;
                  setState(() {});
                } else {
                  opacitySet = 1.0;
                  showLyrics = '';
                  setState(() {});
                }
              },
              child: Text(
                showLyrics == '' ? 'Show Lyrics' : 'Hide Lyrics',
                style: TextStyle(color: Colors.white),
              )),
          IconButton(
            onPressed: () async {
              if (isPlay == false) {
                final player = AudioCache(prefix: 'assets/');
                final url = await player.load(widget.songLocation);
                audioPlayer.play(url.path, isLocal: true);
              } else {
                audioPlayer.pause();
              }
            },
            icon: Icon(isPlay ? Icons.pause : Icons.play_arrow),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
                child: Column(
              children: [
                Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration - position))
                  ],
                ),
              ],
            ))),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.imgLocation),
                fit: BoxFit.cover,
                opacity: opacitySet)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text(showLyrics),
                alignment: Alignment.topLeft,
              )
              //Text(widget.lyric)
            ],
          ),
        ),
      ),
    );
  }
}
//endregion
