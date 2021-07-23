import 'package:flutter/material.dart';

typedef Entered = void Function(String password);

class NumberBoard extends StatefulWidget {
  final Entered onEntered;
  final ValueChanged<String> onValueChaged;
  final bool isPassword;

  NumberBoard({
    Key? key,
    required this.onEntered,
    required this.onValueChaged,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _NumberBoardState createState() => _NumberBoardState();
}

class _NumberBoardState extends State<NumberBoard> {
  final _controller = new TextEditingController();
  String password = '';
  void onNumberClick(String value) {
    _controller.text += value;
    widget.onValueChaged(_controller.text);
  }

  void onEnterClick() {
    widget.onEntered(_controller.text);
  }

  void onDeleteClick() {
    _controller.text = '';
    widget.onValueChaged(_controller.text);
  }

  void _onPasswordInput() {
    password = _controller.text;
    widget.onValueChaged(_controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPasswordInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 250,
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          letterSpacing: 3,
                        ),
                        obscureText: widget.isPassword,
                        obscuringCharacter: "*",
                        enabled: false,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(15),
                        child: GestureDetector(
                          onTap: () {
                            onDeleteClick();
                          },
                          child: Image.asset(
                            'keys/PWDDelete.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _numberButton('1'),
              _numberButton('2'),
              _numberButton('3')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _numberButton('4'),
              _numberButton('5'),
              _numberButton('6')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _numberButton('7'),
              _numberButton('8'),
              _numberButton('9')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _numberButton('0'),
              _enterButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberButton(String value) {
    String imagePath = "keys/PW_KP" + value + ".png";
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () {
          onNumberClick(value);
        },
        child: Image.asset(imagePath),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(0),
          primary: Colors.white.withOpacity(0),
        ),
      ),
    );
  }

  Widget _enterButton() {
    String imagePath = "keys/PWEnter.png";
    return Container(
        margin: EdgeInsets.all(5.0),
        child: ElevatedButton(
            onPressed: () {
              onEnterClick();
            },
            child: Center(
                widthFactor: 1, heightFactor: 1, child: Image.asset(imagePath)),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0)),
                shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder(
                    side: BorderSide(
                        width: 0, color: Colors.white.withAlpha(0)))))));
  }
}
