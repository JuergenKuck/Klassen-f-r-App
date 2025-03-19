class Timer {
  // final properties:
  final int timeStart; //   Startzeit in Sekunden

  // aditional properties
  int timeCurrent = 0; //     Aktuelle Zeit in Sekunden
  bool isRunning = false; //  Der Timer wurde gestartet und läuft
  bool isPause = false; //    Der Timer pausiert

  // contructor
  Timer({required this.timeStart});
}
