import 'package:flutter/material.dart';

void main() {
  runApp(Tela());
}

class Tela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Text(
              'vasco',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 32,
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
                'Campeão',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
