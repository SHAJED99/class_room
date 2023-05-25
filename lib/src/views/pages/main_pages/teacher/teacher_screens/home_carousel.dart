// This file can be replaced with api documentation

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_screens/home_carousel_card.dart';
import 'package:class_room/src/views/widgets/boxes/custom_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({super.key});
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1,
      child: Container(
        constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
        child: CustomCarousel(
          carouselHeight: defaultCarouselHeight * 2,
          selectedDotColor: Theme.of(context).primaryColor,
          dotColor: Theme.of(context).primaryColor.withOpacity(0.5),
          aspectRatio: 1.5,
          productList: dataController.examList,
          onBuild: (element) {
            return HomeCarouselCard(
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${element.value.examName}", maxLines: 2, overflow: TextOverflow.ellipsis, style: defaultTitleStyle1),
                    const SizedBox(height: defaultPadding / 4),
                    Text(DateFormat('dd.MMMM.yyyy\nh:mm a').format(element.value.createOn), style: defaultSubtitle2),
                    const SizedBox(height: defaultPadding / 2),
                    Text("${element.value.examDescription}", maxLines: 3, overflow: TextOverflow.ellipsis, style: buttonText1.copyWith(color: defaultBlackColor)),
                    const SizedBox(height: defaultPadding / 4),
                    const Spacer(),
                    const Divider(height: 1),
                    const SizedBox(height: defaultPadding / 4),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Question: ${element.value.questions.length}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                          const SizedBox(height: defaultPadding / 8),
                          Text("Taken exam: ${element.value.participationTime} times", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
