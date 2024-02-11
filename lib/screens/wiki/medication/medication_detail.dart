import 'package:epilepsy_care_pmk/screens/commons/screen_with_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/styling.dart';

class MedicationDetail extends StatelessWidget {
  const MedicationDetail({
    super.key,
    // required this.title,
  });

  // final String title;

  @override
  Widget build(BuildContext context) {
    return ScreenWithAppBar(
      title: "บันทึกปริมาณยา",
      body: Padding(
        padding: const EdgeInsets.all(kMediumPadding),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(kLargePadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("test")],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
