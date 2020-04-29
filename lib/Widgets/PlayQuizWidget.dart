import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {

    final String option, description, correctAnswer, optionSelected;

    OptionTile( { @required this.option, @required this.description, @required this.correctAnswer, @required this.optionSelected });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: widget.description == widget.optionSelected
                                ? widget.optionSelected == widget.correctAnswer 
                                ? Colors.green.withOpacity(0.7)
                                : Colors.red.withOpacity(0.7) 
                                : Colors.grey
                        ),
                    ),
                    child: new Text("${widget.option}",
                        style: new TextStyle(
                            color: widget.optionSelected == widget.description
                                ? widget.correctAnswer == widget.description
                                ? Colors.green.withOpacity(0.7)
                                : Colors.red
                                : Colors.grey
                        ),
                    ),
                ),
                SizedBox(width: 10.0,)
            ],
        ),
    );
  }
}
