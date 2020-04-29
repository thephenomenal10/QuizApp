import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

    Future<void> addQuizData(Map quizData, String quizId) async {
        await Firestore.instance
            .collection("Quiz")
            .document(quizId)
            .setData(quizData)
            .catchError((e) {
            print(e.toString());
        });
    }

    Future<void> addQuestionData(Map questionData, String quizId) async {
        await Firestore.instance
            .collection("Quiz")
            .document(quizId)
            .collection("QNA")
            .add(questionData)    // .add function automatically generate the ID
            .catchError((e){
                print(e.toString());
            });
    }

    getQuizData() async {
        return await Firestore.instance.collection("Quiz").snapshots();
    }

    getSpecificQuizData(String quizId) async {
        return await Firestore.instance
            .collection("Quiz")
            .document(quizId)
            .collection("QNA")
            .getDocuments();
    }
    
}