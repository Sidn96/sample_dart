import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';

mixin class MoEngagePageEvents {

  //Explore more Blog Event Call
  exploreMoreBlogsEventCall(String category) {
    switch (category) {
      case 'NPS':
        MoEngageService().trackEvent(
          eventName: MoEngageEventsConsts.eventsNames.npsHomepageButtonClicked,
          product: ProductEvent.nps,
          properties: {
            MoEngageEventsConsts.eventAttributesKey.selection:
            MoEngageEventsConsts.eventAttributesValue.npsExploreMoreBlogs,
          },
        );
        break;

      default:
        break;
    }
  }

  //Explore more Video Event Call
  exploreMoreVideoEventCall(String category) {
    switch (category) {
      case 'NPS':
        MoEngageService().trackEvent(
          eventName: MoEngageEventsConsts.eventsNames.npsHomepageButtonClicked,
          product: ProductEvent.nps,
          properties: {
            MoEngageEventsConsts.eventAttributesKey.selection:
            MoEngageEventsConsts.eventAttributesValue.npsExploreMoreVideos,
          },
        );
        break;

      default:
        break;
    }
  }


}