import 'package:flutter/material.dart';

import 'package:final_project_biblical_reference/screens/input_and_response.dart';

class PassageOfReference extends StatelessWidget {
  const PassageOfReference({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      child: const Padding(
        padding: EdgeInsets.only(top: 64.0, left: 32, right: 32),
        child: InputAndResponse(
            query: "Ofera-mi pasajul biblic corespunzator textului: "),
      ),
    );
  }
}
