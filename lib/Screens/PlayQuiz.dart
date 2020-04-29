//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Model/QuestionModel.dart';
import 'package:quizapp/Services/databaseService.dart';
import 'package:quizapp/Widgets/PlayQuizWidget.dart';

import '../MyAppBar.dart';

class PlayQuiz extends StatefulWidget{

    final String quizId;
    PlayQuiz(this.quizId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
        
      return PlayQuizState();
  }
    
}

int total = 0;
int correct = 0;
int incorrect = 0;
int notAttempted = 0;

class PlayQuizState extends State<PlayQuiz> {

    DatabaseService databaseService = new DatabaseService();
    QuerySnapshot questionsSnapshot;


    QuestionModel getQuestionModelFromDatasnapshot(
        DocumentSnapshot questionSnapshot) {
        QuestionModel questionModel = new QuestionModel();

        questionModel.question = questionSnapshot.data["question"];

        /// shuffling the options
        List<String> options = [
            questionSnapshot.data["option1"],
            questionSnapshot.data["option2"],
            questionSnapshot.data["option3"],
            questionSnapshot.data["option4"]
        ];
        options.shuffle();

        questionModel.option1 = options[0];
        questionModel.option2 = options[1];
        questionModel.option3 = options[2];
        questionModel.option4 = options[3];
        questionModel.correctOption = questionSnapshot.data["option1"];
        questionModel.answered = false;

//        print(questionModel.correctOption.toLowerCase());

        return questionModel;
    }

    @override
  void initState() {
        print("${widget.quizId}");
        databaseService.getSpecificQuizData(widget.quizId).then((value){
            questionsSnapshot = value;
            notAttempted = 0;
            correct = 0;
            incorrect = 0;
            total = questionsSnapshot.documents.length;

            print("total qurstions");
            setState(() {

            });
        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return new Scaffold(
          appBar: PreferredSize(
              child: MyAppBar(),
              preferredSize: Size.fromHeight(60.0),
          ),
            body: Container(
                child: Column(
                    children: <Widget>[
                        questionsSnapshot.documents == null
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: questionsSnapshot.documents.length,
                            itemBuilder: (context, index){
                                return QuizPlayTile(
                                    questionModel: getQuestionModelFromDatasnapshot(
                                        questionsSnapshot.documents[index]),
                                     index: index,
                                );
                            }
                        )

                    ],
                ),
            ),
      );
  }
}

class QuizPlayTile extends StatefulWidget {

     final QuestionModel questionModel ;
    final int index;

    QuizPlayTile( {@required this.questionModel, @required this.index} );

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

    String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: <Widget>[
                 Text(widget.questionModel.question),
                SizedBox(height: 4.0,),
                OptionTile(
                    option: "A",
                    description: widget.questionModel.option1,
                    correctAnswer: widget.questionModel.option1,
                    optionSelected: optionSelected,
                ),
                SizedBox(height: 4.0,),
                OptionTile(
                    option: "B",
                    description: widget.questionModel.option1,
                    correctAnswer: widget.questionModel.option2,
                    optionSelected: optionSelected,
                ),
                SizedBox(height: 4.0,),
                OptionTile(
                    option: "C",
                    description: widget.questionModel.option1,
                    correctAnswer: widget.questionModel.option3,
                    optionSelected: optionSelected,
                ),
                SizedBox(height: 4.0,),
                OptionTile(
                    option: "D",
                    description: widget.questionModel.option1,
                    correctAnswer: widget.questionModel.option4,
                    optionSelected: optionSelected,
                ),
            ],
        ),
    );
  }
}


