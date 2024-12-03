import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/new_login_register/domain/entities/user_feedback_quotes_entity.dart';

List<UserFeedbackQuotesEntity> getLoginRegisterUserFeedbackQuotes(
    LoginFormEnum sources) {
  List<UserFeedbackQuotesEntity> npsUserFeedbackQuotes = [
    const UserFeedbackQuotesEntity(
      quotes:
          "TrueFin made investing in NPS a breeze! The platform is intuitive and user-friendly.",
      author: "Aarya Palsule",
      authorDesignation: "Commercial Banker",
    ),
    const UserFeedbackQuotesEntity(
      quotes:
          "Excellent service! TrueFin's NPS investment process is quick and hassle-free.",
      author: "Kundan Nandlal",
      authorDesignation: "Product Manager",
    ),
    const UserFeedbackQuotesEntity(
      quotes:
          "I'm impressed with TrueFin's seamless NPS integration and top-notch customer support.",
      author: "Aditya Kumar",
      authorDesignation: "Analyst, @MNC",
    ),
    const UserFeedbackQuotesEntity(
      quotes:
          "TrueFin offers a superb experience for NPS investments—efficient, reliable, and straightforward!",
      author: "Bavya Mani",
      authorDesignation: "Product Manager",
    )
  ];

  switch (sources) {
    case LoginFormEnum.nps:
      return npsUserFeedbackQuotes;
    default:
      return [];
  }
}
