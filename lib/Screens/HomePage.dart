import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Services/databaseService.dart';

import '../MyAppBar.dart';
import 'PlayQuiz.dart';
import 'createQuiz.dart';

class HomePage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return HomePageState();
    }
}

class HomePageState extends State<HomePage> {

    DatabaseService databaseService = new DatabaseService();
    Stream quizStream;

    Widget quizList() {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: StreamBuilder(
                stream: quizStream,
                builder: (context, snapshot){
                     return snapshot.data == null
                         ? Container()
                         : ListView.builder(
                         itemCount: snapshot.data.documents.length,
                         itemBuilder: (context, index){
                             return QuizTile(
                                 imgUrl: snapshot.data.documents[index].data["quizImageUrl"],
                                 desc: snapshot.data.documents[index].data["quizDescription"],
                                 title: snapshot.data.documents[index].data["quizTitle"],
                                 quizId: snapshot.data.documents[index].data["quizId"],
                             );
                         }
                     );
                }
            ),
        );
    }

    @override
  void initState() {
    // TODO: implement initState
        databaseService.getQuizData().then((value){
           setState(() {
             quizStream = value;
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
            body: quizList(),

            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateQuiz()));
                },
            ),
        );
    }
}


class QuizTile extends StatelessWidget {

    final String imgUrl, title, desc, quizId ;
    QuizTile( { @required this.imgUrl, @required this.title, @required this.desc, @required this.quizId } );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      return GestureDetector(
          onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayQuiz(quizId)));
          },
        child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: 150.0,
            child: Stack(
                  children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                            imgUrl,
                            width: MediaQuery.of(context).size.width - 48,
                            fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black26,

                          ),
                          alignment: Alignment.center,
                          child: Column(
                              children: <Widget>[
                                  Text(title, style: new TextStyle(color: Colors.white, fontSize: 17),),
                                  Text(desc,  style: new TextStyle(color: Colors.white, fontSize: 17)),
                              ],
                          ),
                      ),
                  ],
            ),
        ),
      );
  }

}