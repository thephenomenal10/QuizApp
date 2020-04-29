import 'package:flutter/material.dart';
import 'package:quizapp/Services/databaseService.dart';
import 'package:quizapp/Widgets/BlueButton.dart';
import 'package:random_string/random_string.dart';

import '../MyAppBar.dart';
import 'AddQuestion.dart';


class CreateQuiz extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return CreateQuizState();
    }
}

class CreateQuizState extends State<CreateQuiz> {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    DatabaseService databaseService = new DatabaseService();
    String quizImageUrl, quizTitle, quizDescription, quizId;

    bool _isLoading = false;

    createQuizOnline() async{
        if(_formKey.currentState.validate()){

            setState(() {
              _isLoading = true;
            });

            quizId = randomAlphaNumeric(16);

            Map<String, String> quizMap = {
                "quizId": quizId,
                "quizImageUrl": quizImageUrl,
                "quizDescription": quizDescription,
                "quizTitle": quizTitle
            };
           await databaseService.addQuizData(quizMap, quizId).then((value){
                setState(() {
                  _isLoading = false;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddQuestion(quizId)));
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
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                      children: <Widget>[
                          TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Quiz Image Url" : null,
                              decoration: InputDecoration(
                                  hintText: "Quiz Image Url (Optional)"
                              ),
                              onChanged: (val){
                                  quizImageUrl = val;
                              },
                          ),
                          SizedBox(height: 5,),
                          TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                              decoration: InputDecoration(
                                  hintText: "Quiz Title"
                              ),
                              onChanged: (val){
                                  quizTitle = val;
                              },
                          ),
                          SizedBox(height: 5,),
                          TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                              decoration: InputDecoration(
                                  hintText: "Quiz Description"
                              ),
                              onChanged: (val){
                                  quizDescription = val;
                              },
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                  createQuizOnline();
                              },
                              child: blueButton(
                                  context: context,
                                  label: "Create Quiz",
                                  buttonWidth: 170.0
                              )
                          ),
                          SizedBox(height: 20.0,)
                      ],
                  ),
              )
          ),
      );
  }

}