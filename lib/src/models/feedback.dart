class Feedback {
  final String _title;
  final String _details;
  final String _skill;
  final String _action;
  final String _recipientName;
  final String _senderName;

  Feedback(this._title, this._details, this._skill, this._action,
      this._recipientName, this._senderName);

  String get senderName => _senderName;

  String get recipientName => _recipientName;

  String get action => _action;

  String get skill => _skill;

  String get details => _details;

  String get title => _title;
}
