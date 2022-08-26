import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tflite_audio/tflite_audio.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({required this.car, Key? key}) : super(key: key);
  final Map<String, dynamic> car;
  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  String _sound = 'Press the button to start';
  bool _recording = false;
  late Stream<Map<dynamic, dynamic>> result;

  @override
  void initState() {
    TfliteAudio.loadModel(
        model: 'assets/ann.tflite',
        label: 'assets/labels.txt',
        inputType: 'rawAudio',
        numThreads: 4,
        isAsset: true);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    TfliteAudio.stopAudioRecognition();
    TfliteAudio.setSpectrogramParameters(nMFCC: 40, hopLength: 16384);
  }

  String recognition = '';

  Future<void> _recorder() async {
    if (!_recording) {
      setState(() => _recording = true);
      result = TfliteAudio.startAudioRecognition(
        numOfInferences: 1,
        sampleRate: 44100,
        // audioLength: 3,
        bufferSize: 22016,
      );
      result.listen((Map<dynamic, dynamic> event) {
        setState(() {
          recognition = event['recognitionResult'];
        });
        log(recognition);
      }).onData((_) {
        log(_.toString());
        setState(() {
          _recording = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/car1.png',
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.car['name'],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.car['number'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.car['model'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text('Select your problem'),
                const SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: add functionality
                        },
                        child: const Text('Fuel running low'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: add functionality
                        },
                        child: const Text('Puncture'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: add functionality
                        },
                        child: const Text('Air lock fuel'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {},
                  child: const Text('Find a mechanic'),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recording
            ? () async {
                await TfliteAudio.stopAudioRecognition();
                setState(() {
                  _recording = false;
                  _sound = recognition.split(' ')[1];
                });
                await showDialog(
                  context: context,
                  builder: ((BuildContext context) => AlertDialog(
                        title: const Text('Recognition'),
                        content: Text(_sound),
                      )),
                );
              }
            : _recorder,
        child: Icon(
            _recording ? Icons.rectangle_rounded : Icons.record_voice_over),
      ),
    );
  }
}
