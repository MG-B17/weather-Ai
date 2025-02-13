import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widget/textform.dart';

class CmWidget extends StatelessWidget {

  final String text;
  CmWidget({required this.text});

  var cmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cmController.text=text;
    return Row(
      children: [
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 50.w,
          child: CustomTextForm(
              name: "",
              readOnly: true,
              controller:cmController,
              keyboardType: TextInputType.none,
              onFiledSubmitted: (value){},
              validation:(value){}
          ),
        )
      ],
    );
  }
}
