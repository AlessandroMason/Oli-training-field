import 'package:flutter/material.dart';

class PollingPeople extends StatefulWidget {
  PollingPeople({Key? key, required this.onAnswerSelected, required this.questionselected}) : super(key: key);
  Function(int questionindex, int selectedOption) onAnswerSelected;
  int questionselected;
  @override
  State<PollingPeople> createState() => _PollingPeopleState();
}

class _PollingPeopleState extends State<PollingPeople> {
   Map<int, int> userAnswers = {}; // Store user answers here

  void _onAnswerSelected(int questionIndex, int selectedOption) {
    setState(() {
      userAnswers[questionIndex] = selectedOption;
      widget.onAnswerSelected(questionIndex,selectedOption);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionCard(
                questionIndex: widget.questionselected,
                question: surveyQuestions[widget.questionselected]['question'],
                options: surveyQuestions[widget.questionselected]['options'],
                onAnswerSelected: _onAnswerSelected,
                selectedOption: userAnswers[widget.questionselected],
              ),
      ],
    );
  }
}
class QuestionCard extends StatelessWidget {
  final int questionIndex;
  final String question;
  final List<String> options;
  final Function(int, int) onAnswerSelected;
  final int? selectedOption;

  const QuestionCard({super.key, 
    required this.questionIndex,
    required this.question,
    required this.options,
    required this.onAnswerSelected,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options.asMap().entries.map((entry) {
                int optionIndex = entry.key;
                String optionText = entry.value;
                return RadioListTile<int>(
                  title: Text(optionText),
                  value: optionIndex,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    onAnswerSelected(questionIndex, value ?? 0);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
/*  */
// Example survey questions and options
List<Map<String, dynamic>> surveyQuestions = [
  {
    'question': 'Why did you install Irys?',
    'options': ['Productivity', 'Friendship', 'Journaling', 'All of the above'],
  },
  {
    'question': 'How frequently do you use Irys?',
    'options': ['Daily', 'Weekly', 'Monthly', 'Rarely', 'Never'],
  },
  {
    'question': 'What specific features of Irys do you find most valuable?',
    'options': ['Chats', 'PDF Export', 'Goal Setting', 'Journaling', 'To-Do List'],
  },
  {
    'question': 'On a scale of 1-10, how satisfied are you with the user interface and design of Irys?',
    'options': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
  },
  {
    'question': 'How has Irys improved your daily life or productivity? Please share a specific example.',
    'options': ['Created deeper connections', 'Improved time management', 'Enhanced focus', 'Better organization', ],
  },
  {
    'question': 'What improvements or new features would you like to see in future versions of Irys?',
    'options': ['Integration with other apps', 'Advanced analytics', 'Customizable themes', 'Integration with google calendar'],
  },
  {
    'question': 'Would you recommend Irys to a friend or colleague? Why or why not?',
    'options': ['Definitely', 'Probably', 'Not sure', 'Probably not', 'Definitely not'],
  },
  {
    'question': 'How did you first hear about Irys?',
    'options': ['App Store', 'Social media', 'Friend or family', 'Terapist', 'Coach',],
  },
];
