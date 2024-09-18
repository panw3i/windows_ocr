class TapLock {
  bool _locked = false;

  void preventDoubleTap({required Function action, int delayMs = 500}) {
    if (_locked) return;
    _locked = true;
    action();
    Future.delayed(Duration(milliseconds: delayMs), () {
      _locked = false;
    });
  }
}
