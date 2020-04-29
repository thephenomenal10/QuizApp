import 'package:flutter/material.dart';
import 'package:quizapp/Services/databaseService.dart';
import 'package:quizapp/Widgets/BlueButton.dart';

import '../MyAppBar.dart';


class AddQuestion extends StatefulWidget {

    final String quizId;

    AddQuestion(this.quizId);

    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return AddQuestionState();
    }
}

class AddQuestionState extends State<AddQuestion> {

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    DatabaseService databaseService = DatabaseService();
    
    String question, option1, option2, option3, option4;
    bool _isLoading = false;

    uploadQuestionData() async {
        if(_formKey.currentState.validate()){

            setState(() {
              _isLoading = true;
            });

            Map<String, String> questionMap  = {

                "Question": question,
                "Option1": option1,
                "Option2": option2,
                "Option3": option3,
                "Option4": option4,
            };

            databaseService.addQuestionData(questionMap, widget.quizId).then((value){
                setState(() {
                    _isLoading = false;
                });
            });
        }
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
        return new Scaffold(
            appBar:  PreferredSize(
                child: MyAppBar(),
                preferredSize: Size.fromHeight(60.0),
            ),
            body: _isLoading ? Container(
                child: Center(child: CircularProgressIndicator(),),
            )
            : Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.only(left:10.0, right: 8.0),
                    child: Column(
                        children: <Widget>[
                            TextFormField(
                                validator: (val) => val.isEmpty ? "Enter Question" : null,
                                decoration: InputDecoration(
                                    hintText: "Question",
                                ),
                                onChanged: (val){
                                    question = val;
                                },
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                                validator: (val) => val.isEmpty ? "Option 1" : null,
                                decoration: InputDecoration(
                                    hintText: "Option 1"
                                ),
                                onChanged: (val){
                                    option1 = val;
                                },
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                                validator: (val) => val.isEmpty ? "option2" : null,
                                decoration: InputDecoration(
                                    hintText: "Option 2"
                                ),
                                onChanged: (val){
                                    option2 = val;
                                },
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                                validator: (val) => val.isEmpty ? "option3" : null,
                                decoration: InputDecoration(
                                    hintText: "Option 3"
                                ),
                                onChanged: (val){
                                    option3 = val;
                                },
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                                validator: (val) => val.isEmpty ? "option4" : null,
                                decoration: InputDecoration(
                                    hintText: "Option 4"
                                ),
                                onChanged: (val){
                                    option4 = val;
                                },
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                              child: Row(
                                  children: <Widget>[
                                      GestureDetector(
                                          onTap: (){
                                              uploadQuestionData();
                                              Navigator.pop(context);
                                          },
                                        child: blueButton(
                                            context: context,
                                            label: "Submit",
                                            buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                                        ),
                                      ),
                                      SizedBox(width: 24.0,),
                                      GestureDetector(
                                          onTap: (){

                                              uploadQuestionData();
                                          },
                                        child: blueButton(
                                            context: context,
                                            label: "Add Question",
                                            buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                                        ),
                                      )
                                  ],
                              ),
                            ),

                        ],
                    ),
                )
            )
        );
  }

}