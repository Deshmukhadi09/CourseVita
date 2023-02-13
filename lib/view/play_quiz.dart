import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_stream/model/question_model.dart';
import 'package:video_stream/services/database.dart';
import 'package:video_stream/widgets/quiz_play_widgets.dart';
import 'package:video_stream/widgets/video_dialog.dart';

var firebaseUser = FirebaseAuth.instance.currentUser;
// String firebaseId = firebaseUser!.uid.toString;
final userId = firebaseUser?.email.toString();

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  final String dayId;

  const QuizPlayTile(
      {Key? key,
      required this.questionModel,
      required this.index,
      required this.dayId})
      : super(key: key);

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  DataBaseServices dataBaseServices = DataBaseServices();

  _setData(String q, String a) {
    var documentReference = FirebaseFirestore.instance
        .collection("Response")
        .doc(userId)
        .collection("ans")
        .doc(widget.dayId)
        .collection("Responce")
        .doc();

    Map<String, dynamic> teams = {
      "question": q,
      "ans": a,
    };
    documentReference
        .set(teams)
        .whenComplete(() => print("ans save succesfully"));
  }

  @override
  void initState() {
    dataBaseServices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Text(
          "Q${widget.index} : ${widget.questionModel.question}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          height: 12,
        ),
        if (widget.questionModel.option1 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option1);
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option1 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option2 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option2);
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option2 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option3 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option3);
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option3 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option4 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option4);
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option4 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option5 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option5);
                optionSelected = widget.questionModel.option5;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option5,
              option: "E",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option5 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option6 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option6);
                optionSelected = widget.questionModel.option6;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option6,
              option: "F",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option6 != "No")
          const SizedBox(
            height: 4,
          ),
      ],
    );
  }
}

class QuizPlayTile2 extends StatefulWidget {
  final String questionModel;
  final int index;
  final String dayId;

  const QuizPlayTile2(
      {Key? key,
      required this.questionModel,
      required this.index,
      required this.dayId})
      : super(key: key);

  @override
  _QuizPlayTile2State createState() => _QuizPlayTile2State();
}

class _QuizPlayTile2State extends State<QuizPlayTile2> {
  String optionSelected = "";
  DataBaseServices dataBaseServices = DataBaseServices();
  TextEditingController ansController = TextEditingController();

  _setData(String q, String a) {
    var documentReference = FirebaseFirestore.instance
        .collection("Response")
        .doc(userId)
        .collection("ans")
        .doc(widget.dayId)
        .collection("Responce")
        .doc();

    Map<String, dynamic> teams = {
      "question": q,
      "ans": a,
    };

    documentReference
        .set(teams)
        .whenComplete(() => print("ans save succesfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Text(
          "Q${widget.index} : ${widget.questionModel}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          minLines: 2,
          maxLines: 10,
          controller: ansController,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
              hintText: "Write your ans here",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            _setData(widget.questionModel, ansController.text);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class QuizPlayTile3 extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  final String dayId;
  final String videoUrl;

  const QuizPlayTile3(
      {Key? key,
      required this.questionModel,
      required this.index,
      required this.dayId,
      required this.videoUrl})
      : super(key: key);

  @override
  _QuizPlayTile3State createState() => _QuizPlayTile3State();
}

class _QuizPlayTile3State extends State<QuizPlayTile3> {
  String optionSelected = "";
  DataBaseServices dataBaseServices = DataBaseServices();

  _setData(String q, String a) {
    var documentReference = FirebaseFirestore.instance
        .collection("Response")
        .doc(userId)
        .collection("ans")
        .doc(widget.dayId)
        .collection("Responce")
        .doc();

    Map<String, dynamic> teams = {
      "question": q,
      "ans": a,
    };
    documentReference
        .set(teams)
        .whenComplete(() => print("ans save succesfully"));
  }

  playVideo(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: SizedBox(
                  height: 250,
                  width: 400,
                  child: VideoWidget(url: widget.videoUrl, play: true)));
        });
  }

  @override
  void initState() {
    dataBaseServices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Text(
          "Q${widget.index} : ${widget.questionModel.question}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              playVideo(context);
            },
            child: const Text("Watch Video"),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        if (widget.questionModel.option1 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option1);
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option1 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option2 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option2);
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option2 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option3 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option3);
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option3 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option4 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option4);
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option4 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option5 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option5);
                optionSelected = widget.questionModel.option5;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option5,
              option: "E",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option5 != "No")
          const SizedBox(
            height: 4,
          ),
        if (widget.questionModel.option6 != "No")
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                _setData(widget.questionModel.question,
                    widget.questionModel.option6);
                optionSelected = widget.questionModel.option6;
                widget.questionModel.answered = true;
                setState(() {});
              }
            },
            child: OptionTile(
              description: widget.questionModel.option6,
              option: "F",
              optionSelected: optionSelected,
            ),
          ),
        if (widget.questionModel.option6 != "No")
          const SizedBox(
            height: 4,
          ),
      ],
    );
  }
}
