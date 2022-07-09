import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int _numberOfRepetitions = 1;
  int _numberOfBlockRepetitions = 1;
  int _blockSize = 1;
  bool _repeatEverySentence = false;
  bool _enableVoiceCommand = false;
  bool _repeatInBlocks = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController _repeatAmountController = TextEditingController();
  final TextEditingController _blockSizeController = TextEditingController();
  final TextEditingController _blockRepeatAmountController =
      TextEditingController();

  @override
  void initState() {
    loadNumberOfRepetitions();
    loadRepeatingEverySentence();
    loadNumberOfBlockRepetitions();
    loadBlockSize();
    loadRepeatInBlocks();
    loadEnabledVoiceCommands();
    super.initState();
  }

  void loadNumberOfRepetitions() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _numberOfRepetitions = (prefs.getInt('numberOfRepetitions') ?? 1);
    });
  }

  void loadNumberOfBlockRepetitions() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _numberOfBlockRepetitions =
          (prefs.getInt('numberOfBlockRepetitions') ?? 1);
    });
  }

  void loadBlockSize() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _blockSize = (prefs.getInt('blockSize') ?? 1);
    });
  }

  void loadRepeatingEverySentence() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _repeatEverySentence = (prefs.getBool('repeatEverySentence') ?? false);
    });
  }

  void loadEnabledVoiceCommands() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _enableVoiceCommand = (prefs.getBool('enableVoiceCommand') ?? false);
    });
  }

  void loadRepeatInBlocks() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _repeatInBlocks = (prefs.getBool('repeatInBlocks') ?? false);
    });
  }

  void setNumberOfRepetitions(int val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('numberOfRepetitions', val);
  }

  void setBlockSize(int val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('blockSize', val);
  }

  void setNumberOfBlockRepetitions(int val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('numberOfBlockRepetitions', val);
  }

  void setRepeatingEverySentence(bool val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('repeatEverySentence', val);
  }

  void setRepeatInBlocks(bool val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('repeatInBlocks', val);
  }

  void setEnabledVoiceCommands(bool val) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('enableVoiceCommand', val);
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                color: CustomColors.greyText, size: 40),
            onPressed: () async {
              if (_repeatAmountController.text.isNotEmpty) {
                setNumberOfRepetitions(int.tryParse(
                        _repeatAmountController.value.text.toString()) ??
                    1);
              }
              setRepeatingEverySentence(_repeatEverySentence);
              setEnabledVoiceCommands(_enableVoiceCommand);
              setRepeatInBlocks(_repeatInBlocks);
              if (_blockSizeController.text.isNotEmpty) {
                setBlockSize(
                    int.tryParse(_blockSizeController.value.text.toString()) ??
                        1);
              }
              if (_blockRepeatAmountController.text.isNotEmpty) {
                setNumberOfBlockRepetitions(int.tryParse(
                        _blockRepeatAmountController.value.text.toString()) ??
                    1);
              }
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
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.height * 0.02),
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
                                _repeatEverySentence ^= true;
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
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _repeatAmountController,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.04,
                  thickness: 1,
                  color: CustomColors.greyBorder,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Repeat in blocks',
                          style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Switch(
                            value: _repeatInBlocks,
                            onChanged: (value) {
                              setState(() {
                                _repeatInBlocks ^= true;
                              });
                            }))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Block size', style: TextStyle(fontSize: 20)),
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
                        controller: _blockSizeController,
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
                            hintText: _blockSize.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Repeat amount for each block',
                          style: TextStyle(fontSize: 20)),
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
                        controller: _blockRepeatAmountController,
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
                            hintText: _numberOfBlockRepetitions.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.04,
                  thickness: 1,
                  color: CustomColors.greyBorder,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
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
                                  _enableVoiceCommand ^= true;
                                });
                              }))
                    ],
                  ),
                ),
              ],
            )));
  }
}
