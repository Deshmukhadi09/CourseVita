import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_stream/model/question_model.dart';
import 'package:video_stream/services/database.dart';
import 'package:video_stream/view/home.dart';
import 'package:video_stream/view/play_quiz.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  final String dayId;
  final int indeX;
  const VideoPlayer(
      {Key? key, required this.url, required this.dayId, required this.indeX})
      : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  DataBaseServices dataBaseServices = DataBaseServices();
  QuerySnapshot? questionSnapshot;
  QuerySnapshot? questionSnapshot2;
  QuerySnapshot? questionSnapshot3;
  final _meeduPlayerController = MeeduPlayerController();
  int qCount = 0;
  String? dayId;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot["question"];

    questionModel.option1 = questionSnapshot["option1"];
    questionModel.option2 = questionSnapshot["option2"];
    questionModel.option3 = questionSnapshot["option3"];
    questionModel.option4 = questionSnapshot["option4"];
    questionModel.option5 = questionSnapshot["option5"];
    questionModel.option6 = questionSnapshot["option6"];

    questionModel.correctOption = questionSnapshot["correctOption"];
    questionModel.answered = questionSnapshot["answered"]; //false;

    return questionModel;
  }

  QuestionModel getQuestionModel3FromDataSnapshot(
      DocumentSnapshot questionSnapshot3) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot3["question"];

    questionModel.option1 = questionSnapshot3["option1"];
    questionModel.option2 = questionSnapshot3["option2"];
    questionModel.option3 = questionSnapshot3["option3"];
    questionModel.option4 = questionSnapshot3["option4"];
    questionModel.option5 = questionSnapshot3["option5"];
    questionModel.option6 = questionSnapshot3["option6"];

    questionModel.correctOption = questionSnapshot3["correctOption"];
    questionModel.answered = questionSnapshot3["answered"]; //false;

    return questionModel;
  }

  @override
  void initState() {
    super.initState();

    dayId = widget.dayId;

    _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        source: widget.url,
      ),
      autoplay: true,
    );

    dataBaseServices.getQuizuzData(widget.dayId).then((value) {
      questionSnapshot = value;
      setState(() {});
    });

    dataBaseServices.getQuizuzData2(widget.dayId).then((value) {
      questionSnapshot2 = value;
      setState(() {});
    });

    dataBaseServices.getQuizuzData3(widget.dayId).then((value) {
      questionSnapshot3 = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _meeduPlayerController.dispose();
    super.dispose();
  }

  _setDataEnd() {
    var documentReference = dataBaseServices.setTime(widget.dayId);

    // Map<String, dynamic> teams = {
    //   "endTime": Timestamp.now(),
    // };

    documentReference.update({"endTime": Timestamp.now()}).whenComplete(
        () => print("ans save succesfully"));
  }

  // _setDataStart() {
  //   var documentReference = FirebaseFirestore.instance
  //       .collection("Timestamp")
  //       .doc()
  //       .collection("days")
  //       .doc(widget.url);

  //   Map<String, dynamic> teams = {
  //     "day": widget.dayId,
  //     "startTime": Timestamp.now(),
  //   };
  //   documentReference
  //       .set(teams)
  //       .whenComplete(() => print("ans save succesfully"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 249, 92, 94).withOpacity(0.9),
            Color.fromARGB(255, 249, 92, 94).withOpacity(0.7),
          ],
          begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight,
        )),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                //here we can use for video streaming
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: MeeduVideoPlayer(
                      controller: _meeduPlayerController,
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    if (questionSnapshot2 != null)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: questionSnapshot2!.docs.length,
                        itemBuilder: (context, index) {
                          qCount = qCount + 1;
                          return QuizPlayTile2(
                              questionModel: questionSnapshot2!.docs[index]
                                  ["question"],
                              index: qCount,
                              dayId: widget.dayId);
                        },
                      ),
                    if (questionSnapshot3 != null)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: questionSnapshot3!.docs.length,
                        itemBuilder: (context, index) {
                          qCount = qCount + 1;
                          return QuizPlayTile3(
                              questionModel: getQuestionModel3FromDataSnapshot(
                                  questionSnapshot!.docs[index]),
                              index: qCount,
                              dayId: widget.dayId,
                              videoUrl: questionSnapshot3!.docs[index]["url"]);
                        },
                      ),
                    if (questionSnapshot != null)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: questionSnapshot!.docs.length,
                        itemBuilder: (context, index) {
                          qCount = qCount + 1;
                          return QuizPlayTile(
                              questionModel: getQuestionModelFromDataSnapshot(
                                  questionSnapshot!.docs[index]),
                              index: qCount,
                              dayId: widget.dayId);
                        },
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _setDataEnd();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Submitted Succesfully!"),
                                  backgroundColor: Colors.greenAccent));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text("Submit your test"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
