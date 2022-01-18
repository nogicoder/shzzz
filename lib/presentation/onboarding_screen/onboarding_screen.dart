import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/index.dart';

/// [OnboardingScreen] displays the welcome images and texts that introduce
/// users about the app's main functionalities
/// Navigate to [RegisterScreen] after completion
//ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
  final PageController controller = PageController();

  var currentIndex = 0.obs;

  final titles = [
    tr().onboarding_1_title,
    tr().onboarding_2_title,
    tr().onboarding_3_title,
  ];

  final descs = [
    tr().onboarding_1_desc,
    tr().onboarding_2_desc,
    tr().onboarding_3_desc,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.kPaddingStandard,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(child: _buildPageView()),
          _buildIndicators(),
          SizedBox(height: Constants.kOuterPadding),
          _buildButtons(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: controller,
      onPageChanged: (index) => currentIndex.value = index,
      children: List<Widget>.generate(
        titles.length,
        (index) => _buildOnboardingPage(
          index,
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: Get.height * 0.35,
          child: ImageAssets.pngAsset(
              '${ImageAssets.image_path}/onboarding_${index + 1}.png'),
        ),
        Container(
          height: Get.height * 0.07,
          alignment: Alignment.bottomCenter,
          child: Text(
            titles[index],
            style: UITextStyle.headline6(true)
                ?.copyWith(color: Get.theme.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Constants.kOuterPadding),
        SizedBox(
          height: Get.height * 0.1,
          child: Text(
            descs[index],
            style: UITextStyle.subtitle1()
                ?.copyWith(color: Get.theme.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicators() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          titles.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 8,
            child: CircleAvatar(
              backgroundColor: currentIndex.value == index
                  ? Get.theme.primaryColor
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Obx(
      () => UIButton(
        title: currentIndex.value != titles.length - 1
            ? tr().next
            : tr().start_now,
        onTap: () {
          if (currentIndex.value != titles.length - 1) {
            controller.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.linear);
          } else {
            userConfigService.setOnboarded();
            Get.toNamed(Routes.REGISTER_SCREEN);
          }
        },
      ),
    );
  }
}
