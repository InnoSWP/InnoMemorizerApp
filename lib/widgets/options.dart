import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  var _numberOfRepetitions = 1;
  var _repeatEverySentence = false;
  var _enableVoiceCommand = false;

  final TextEditingController _repetitionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNumberOfRepetitions();
    loadRepeatingEverySentence();
    loadEnabledVoiceCommands();
  }

  void loadNumberOfRepetitions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _numberOfRepetitions = (prefs.getInt('numberOfRepetitions') ?? 1);
  }

  void loadRepeatingEverySentence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _repeatEverySentence = (prefs.getBool('repeatEverySentence') ?? false);
  }

  void loadEnabledVoiceCommands() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _enableVoiceCommand = (prefs.getBool('enableVoiceCommand') ?? false);
  }

  void setNumberOfRepetitions(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('numberOfRepetitions', val);
  }

  void setRepeatingEverySentence(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('repeatEverySentence', val);
  }

  void setEnabledVoiceCommands(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('enableVoiceCommand', val);
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: CustomColors.greyText, size: 40),
            onPressed: () async {
              setNumberOfRepetitions(
                  int.tryParse(_repetitionsController.value.text.toString()) ??
                      1);
              setRepeatingEverySentence(_repeatEverySentence);
              setEnabledVoiceCommands(_enableVoiceCommand);
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Options',
              style: TextStyle(
                  color: CustomColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 28)),
        ),
        body: Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('Repeat each sentence',
                          style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Switch(
                            value: _repeatEverySentence,
                            onChanged: (value) {
                              setState(() {
                                _repeatEverySentence = !_repeatEverySentence;
                              });
                            }))
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child:
                          Text('Repeat amount', style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05),
                      height: 35,
                      width: 70,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _repetitionsController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CustomColors.blueBorder),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CustomColors.darkBlueBorder),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: _numberOfRepetitions.toString()),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Enable voice commands',
                          style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Switch(
                            value: _enableVoiceCommand,
                            onChanged: (value) {
                              setState(() {
                                _enableVoiceCommand = !_enableVoiceCommand;
                              });
                            }))
                  ],
                )
              ],
            )));
  }
}

class MyToggle extends StatelessWidget {
  const MyToggle({Key? key, required this.onToggleHandler}) : super(key: key);

  final Function(void) onToggleHandler;

  final Color color1 = Colors.white;
  final Color color2 = CustomColors.primary;

  @override
  Widget build(context) {
    return ToggleSwitch(
        //minWidth: MediaQuery.of(context).size.width * 0.34,
        //minHeight: MediaQuery.of(context).size.height * 0.04,
        cornerRadius: 40.0,
        activeBgColors: const [
          [CustomColors.primary],
          [CustomColors.primary]
        ],
        inactiveBgColor: CustomColors.background,
        //initialLabelIndex: _initialIndex,
        totalSwitches: 2,
        borderColor: const [CustomColors.primary, CustomColors.primary],
        borderWidth: 2,
        //labels: const ['Paste text', 'Upload'],
        radiusStyle: true,
        onToggle: onToggleHandler);
  }
}
