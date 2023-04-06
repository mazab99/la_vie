import 'package:flutter/cupertino.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/constants.dart';

class Question with ChangeNotifier {
  int questNum = 1;
  int selectedAnswer = -1;
  int userPoints = 0;
  final List questions = const [
    "In general, plants could be divided into which two main groups?",
    "Why do some plants have sharp thorns or spines?",
    "How do dandelions spread their seeds for reproduction?",
    "Approximately how many years can an oak tree live for?",
    "What is photosynthesis?",
    "What should we do when plants are losing leaves and have pale green growth?",
  ];
  final List answers = const [
    [
      "Flowering plants and non-flowering plants",
      "Fruiting plants and non-fruiting plants",
      "Deciduous plants and evergreen plants",
    ],
    [
      "To attract bees and other pollinators",
      "To collect more water and sunlight",
      "To defence against animals that feed on them",
    ],
    [
      "To let their seeds spread on the water",
      "To let their seeds carried by birds or animals",
      "To let their seeds fly with the wind",
    ],
    [
      "100 years",
      "1,000 years",
      "10,000 years",
    ],
    [
      "The process in which plants release wastes",
      "The process in which plants make food from sunlight",
      "The process in which plants reproduce",
    ],
    [
      "To move them into shade areas",
      "To add more sunlight",
      "To reduce watering",
    ]
  ];
  final List correctAnswers = const [1, 3, 3, 2, 2, 2];

  List userAnswers = List<int>.filled(6, -1, growable: false);
  void selectAnswer(int val) {
    selectedAnswer = val;
    userAnswers[questNum - 1] = val;
    notifyListeners();
  }

  String? next() {
    if (questNum != 6) {
      if (userAnswers[questNum - 1] == -1) {
        return 'Choose answer first';
      } else {
        userAnswers[questNum - 1] = selectedAnswer;
        selectedAnswer = -1;
        if (userAnswers[questNum] != -1) selectedAnswer = userAnswers[questNum];

        questNum++;
      }
    } else {
      for (var i = 0; i < 6; i++) {
        if (correctAnswers[i] == userAnswers[i]) userPoints++;
      }
      points += userPoints;
      CacheHelper.setData(key: "userPoints", value: points);

      return 'You earned $userPoints points!';
    }
    notifyListeners();
    return null;
  }

  void back() {
    questNum--;
    selectedAnswer = userAnswers[questNum - 1];
    notifyListeners();
  }
}
