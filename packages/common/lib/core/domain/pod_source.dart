
/// Available source type
class PodSource {
  static final PodSource _instance = PodSource._internal();
  static const String nps         = 'nps';
  static const String signUp      = 'signup';
  static const String signIn      = 'signin';
  static const String rcHB        = 'rc-hb';
  static const String rcRRR       = 'rc-rrr';
  static const String rcFC        = 'rc-fc';
  static const String rcSUB       = 'rc-sub';
  static const String rcAOE       = 'rc-aoe';
  static const String health      = 'health';
  static const String saving      = 'savings';
  static const String elderCare   = 'eldercare';
  static const String rcPersona   = 'rc-persona';
  static const String rcRiskProfile   = 'rc-risk-profile';

  factory PodSource() {
    return _instance;
  }

  PodSource._internal();

}