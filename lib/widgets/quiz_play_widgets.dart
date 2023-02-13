import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, optionSelected;

  const OptionTile(
      {required this.description,
      required this.option,
      required this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description == widget.optionSelected
                      ? Colors.green.withOpacity(0.7)
                      : Colors.grey,
                  width: 1.4),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "${widget.option}",
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.green.withOpacity(0.7)
                      : Colors.black54),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
