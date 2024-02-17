
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oli_training_field/old_possible_pages/Polling_people.dart';


class AddPannelpollingPeople extends StatefulWidget {
  
 
  AddPannelpollingPeople({super.key, required this.questionnum, required this.uid, required this.onboarding});
  int questionnum;
  String uid;
  bool onboarding;
  @override
  State<AddPannelpollingPeople> createState() => _AddPannelpollingPeopleState();
}

class _AddPannelpollingPeopleState extends State<AddPannelpollingPeople> {
 
  final GlobalKey _formKey = GlobalKey<FormState>();
  FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 0);

  int _actionChosen = 0;
  int _questionChosen = 0;
  bool flag=false;

  onanswerchosen(int questionchosen, int answerchosen){
    setState(() {
      _actionChosen=answerchosen;
      _questionChosen=questionchosen;
      flag=true;
    });
  }

  @override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();
     
    if(flag){
        //!other logic
    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: const Color(0xfff757575),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              
                  PollingPeople(onAnswerSelected: onanswerchosen, questionselected: widget.questionnum,),
                  const SizedBox(height: 40),
                 !widget.onboarding?ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(Colors.white as int),
                      // Set the background color of the button
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Thank you!'),
                            ),
                          );
                      //Update firebase with the answer
                      Navigator.maybePop(context);
                    },
                    child: const Text('Submit'),
                  ):Container(),
                ],
              ),
            )),
      ),
    );
  }
}
