import 'package:flutter/material.dart';
import 'package:la_vie/provider/bottom_nav_bar.dart';
import 'package:la_vie/provider/question_provider.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/answer_item.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

class _QuestionScreen extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var provider = Provider.of<Question>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (34 / Screen.screenWidth) * Screen.screenWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 34),
                    child: Text("Course Exam",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19))),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          children: [
                        const TextSpan(
                            text: "Question ", style: TextStyle(fontSize: 36)),
                        TextSpan(
                            text: "${provider.questNum}",
                            style: const TextStyle(
                                color: AppColors.primary, fontSize: 36)),
                        const TextSpan(
                            text: "/6",
                            style: TextStyle(
                                color: AppColors.customGrey, fontSize: 14)),
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text("${provider.questions[provider.questNum - 1]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      answerItem(
                          title: provider.answers[provider.questNum - 1][0],
                          value: 1,
                          groupValue: provider.selectedAnswer,
                          onChanged: (value) {
                            provider.selectAnswer(value as int);
                          }),
                      answerItem(
                          title: provider.answers[provider.questNum - 1][1],
                          value: 2,
                          groupValue: provider.selectedAnswer,
                          onChanged: (value) {
                            provider.selectAnswer(value as int);
                          }),
                      answerItem(
                          title: provider.answers[provider.questNum - 1][2],
                          value: 3,
                          groupValue: provider.selectedAnswer,
                          onChanged: (value) {
                            provider.selectAnswer(value as int);
                          }),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: provider.questNum != 1
                                  ? ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                      color: AppColors.primary,
                                                      width: 2)))),
                                      onPressed: () {
                                        Provider.of<Question>(context,
                                                listen: false)
                                            .back();
                                      },
                                      child: const Text(
                                        "Back",
                                        style:
                                            TextStyle(color: AppColors.primary),
                                      ),
                                    )
                                  : Container()),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primary),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)))),
                                onPressed: () {
                                  var result = Provider.of<Question>(context,
                                          listen: false)
                                      .next();
                                  if (result != null) {
                                    Toast.show(result, duration: 2);
                                    if (result.contains("point")) {
                                      Provider.of<BottomNavBar>(context,
                                              listen: false)
                                          .changeSelected(4);
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: const Text("Next")),
                          )
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
