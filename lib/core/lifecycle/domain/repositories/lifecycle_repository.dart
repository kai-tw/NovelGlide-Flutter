abstract class LifecycleRepository {
  Stream<void> get onShow;

  Stream<void> get onDetach;

  Stream<void> get onResume;

  Stream<void> get onInactive;

  Stream<void> get onHide;

  Stream<void> get onPause;
}
