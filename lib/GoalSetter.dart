import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:needy_new/GoalDate.dart';
import 'package:needy_new/MyScaffold.dart';
import 'package:needy_new/PetCarousel.dart';

class GoalSetter extends StatelessWidget {
  GoalSetter({Key key, this.userId, this.name});

  final String userId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      userId: userId,
      name: name,
      body: GoalForm(userId: userId, name: name),
    );
  }
}

class GoalForm extends StatefulWidget {
  GoalForm({Key key, this.userId, this.name});

  final String userId;
  final String name;

  @override
  _GoalFormState createState() {
    return _GoalFormState(userId: userId, name: name);
  }
}

class _GoalFormState extends State<GoalForm> {
  _GoalFormState({Key key, this.userId, this.name});

  final String userId;
  final String name;
  String _petName;
  String _petType = 'cat';
  String goalName;
  String _creatureName;

  final _formKey = GlobalKey<FormState>();
  final newGoalController = TextEditingController();
  final databaseReference = Firestore.instance;

  // TODO: Add better layout/constraints, handle different pets

  void changeCreatureName(name) {
    _petName = name;
  }

  @override
  Widget build(BuildContext context) {
    print('goalsetter: $userId $name');
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select the creature you will take care of!',
                style: TextStyle(
                  fontFamily: 'Pixelar',
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 180.0,
                  width: 300,
                  child: CarouselDemo(changeCreatureName: changeCreatureName)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Give the creature a name!',
                style: TextStyle(
                  fontFamily: 'Pixelar',
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name!';
                  }
                },
                onSaved: (String value) {
                  _petName = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: 'enter a name...',
                  hintStyle: TextStyle(
                    fontFamily: 'Pixelar',
                    fontSize: 26,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Pixelar',
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'What is your overall goal?',
                style: TextStyle(
                  fontFamily: 'Pixelar',
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: newGoalController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a goal!';
                  }
                  return null;
                },
                onSaved: (String value) {
                  goalName = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: 'enter a goal...',
                  hintStyle: TextStyle(
                    fontFamily: 'Pixelar',
                    fontSize: 26,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Pixelar',
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.pink,
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    color: Colors.yellow,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    addNewGoal(newGoalController);
                    navigateToDatePage(context);
                    print(goalName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future navigateToDatePage(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoalDate(
                goalName: goalName,
                userId: userId,
                petName: _petName,
                petType: _petType)));
  }

  void addNewGoal(goal) {
    databaseReference
        .collection('users')
        .document(userId)
        .collection('goals')
        .document(goal.text)
        .setData({
      'goal': goal.text,
    }).then((res) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Goal added!'),
        ),
      );
      goal.clear();
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
        ),
      );
    });
  }
}
