import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../providers/address_map_provider.dart';
import '../screens/google_map_page.dart';
import 'locate_me_button.dart';

class MapBodyWidget extends HookConsumerWidget {
  final Function()? onPermanentDenied;
  const MapBodyWidget({
    super.key,
    this.onPermanentDenied,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isLoading = useState<bool>(false);
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMapPage(
          onTap: (latLang) async {
            ref.read(latLangCommonCallProvider(latLang));
          },
        ),
        Positioned(
          bottom: 5.0,
          child: kIsWeb
              ? PointerInterceptor(child: LocateMeButton(isLoading: isLoading))
              : LocateMeButton(
                  isLoading: isLoading,
                  onPermanentDenied: onPermanentDenied,
                ),
        ),
      ],
    );
  }
}
