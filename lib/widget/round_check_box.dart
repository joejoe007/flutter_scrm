import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';

class RoundCheckBox extends StatefulWidget {
  var value = false;

  bool stateSelf = true;

  Function(bool) onChanged;

  RoundCheckBox(
      {Key key, @required this.value, this.onChanged, this.stateSelf = true})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            widget.value = !widget.value;
            widget.onChanged(widget.value);
            if(widget.stateSelf){
              setState(() {});
            }
          },
          child: Center(
            child: widget.value
                ? Icon(
                    Icons.check_circle,
                    size: Screen.w(25),
                    color: AppColors.color_ff3c48,
                  )
                : Icon(
                    Icons.panorama_fish_eye,
                    size: Screen.w(25),
                    color: Colors.grey,
                  ),
          )),
    );
  }
}
