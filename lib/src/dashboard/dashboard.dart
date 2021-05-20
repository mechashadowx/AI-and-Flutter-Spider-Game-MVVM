class Dashboard {
  static int maxScore = 3;

  int antScore, spiderScore;

  Dashboard(this.antScore, this.spiderScore);

  void antGotPoint() {
    antScore++;
  }

  void spiderGotScore() {
    spiderScore++;
  }
}
