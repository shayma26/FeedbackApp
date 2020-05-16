enum skillAction { stop_that, keep_doing, take_action }

class SentFeedback {
  String feedbackSender;
  String feedbackRecipient;
  String feedbackText;
  String feedbackTitle;
  String feedbackSkill;
  String feedbackAction;

  SentFeedback(
      {this.feedbackAction,
      this.feedbackRecipient,
      this.feedbackSender,
      this.feedbackSkill,
      this.feedbackText,
      this.feedbackTitle});
}
