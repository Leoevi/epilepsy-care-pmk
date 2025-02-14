import 'package:epilepsy_care_pmk/screens/wiki/medication/medication.dart';
import 'package:epilepsy_care_pmk/screens/wiki/symptoms/symptom.dart';
import 'package:epilepsy_care_pmk/screens/wiki/wiki.dart';
import 'package:epilepsy_care_pmk/services/lifecycle_watcher_state.dart';
import 'package:epilepsy_care_pmk/services/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import '../constants/styling.dart';
import '../custom_widgets/home_drawer.dart';
import '../models/alarm.dart';
import '../services/notification_service.dart';
import 'add_event/add_select.dart';
import 'add_event/med_intake/add_med_intake_input.dart';
import 'calendar/calendar.dart';
import 'contacts/contact.dart';
import 'home/home.dart';

/// The main page of the app. Has a bottom navigation bar that has access each
/// pages of the app.
class MainPage extends StatefulWidget {
  /// Whether or not to display onboarding process. Most of the time, this will
  /// be false, but for the first time after registering, this will be passed in
  /// as true.
  final bool doOnboarding;

  const MainPage({
    super.key,
    this.doOnboarding = false
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return OnboardingIntermediate(doOnboarding: widget.doOnboarding,);
  }
}

/// A class that contains information relating to the onboarding process which
/// will introduce the user to the application the first time after they've
/// registered. Can also be triggered again using an entry in the hamburger
/// menu.
///
/// The reason for using an intermediate is if we instead opted to wrap the
/// whole [MaterialApp] in main instead, during the first registration process
/// when [Navigator.pushReplacement] is called, it will discard the [Onboarding]
/// widget from the widget tree, which cause an error when showing the
/// onboarding process.
class OnboardingIntermediate extends StatefulWidget {
  final bool doOnboarding;

  const OnboardingIntermediate({
    super.key,
    required this.doOnboarding,
  });

  @override
  State<OnboardingIntermediate> createState() => OnboardingIntermediateState();
}

class OnboardingIntermediateState extends State<OnboardingIntermediate> {
  /// [FocusNode] that can be associated with widget of interest that we want to
  /// highlight during the onboarding process. If we didn't associate a node
  /// with any widget, then the overlay will cover the whole screen.
  late final List<FocusNode> focusNodes;
  /// Detail of each onboarding steps.
  late final List<OnboardingStep> steps;

  @override
  void initState() {
    super.initState();
    focusNodes = List<FocusNode>.generate(8, (index) => FocusNode(), growable: false);
    steps = [
      OnboardingStep(
        focusNode: focusNodes[0],
        titleText: "ยินดีต้อนรับ",
        bodyText: "ก่อนเริ่มต้น ขอแนะนำฟังก์ชันพื้นฐานของแอปพลิเคชันเป็นครั้งแรกก่อน แตะเพื่อดูคำแนะนำถัดไป",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[1],
        titleText: "หน้าแรก",
        bodyText: "สามารถดูข้อมูลที่บันทึกล่าสุด และเข้าถึงฟังก์ชันอื่น ๆ เพิ่มเติมได้",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[2],
        titleText: "ปุ่มฟังก์ชันเพิ่มเติม",
        bodyText: "สามารถแก้ไขข้อมูลส่วนตัว ดูสรุปประวัติ และตั้งเวลาแจ้งเตือนทานยาได้",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[3],
        titleText: "ปฏิทิน",
        bodyText: "สามารถดูข้อมูลที่ได้บันทึกเป็นรายวันได้",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[4],
        titleText: "ปุ่มบวก",
        bodyText: "สามารถเพิ่มเหตุการณ์การชัก การแพ้ยา และการทานยาได้",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[5],
        titleText: "ข้อมูล",
        bodyText: "สามารถอ่านข้อมูลที่ควรรู้และยาที่เกี่ยวข้องกับโรคลมชักได้",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[6],
        titleText: "ติดต่อ",
        bodyText: "ช่องทางการติดต่อต่าง ๆ กับทางหน่วยประสาทวิทยา",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
      OnboardingStep(
        focusNode: focusNodes[7],
        titleText: "เสร็จสิ้น",
        bodyText: "สำหรับการรับชมการแนะนำใหม่นี้อีกครั้ง สามารถทำได้จากปุ่มฟังก์ชันเพิ่มเติมในหน้าหลัก",
        hasLabelBox: false,
        fullscreen: true,
        overlayColor: Colors.black.withOpacity(0.8),
        hasArrow: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Onboarding(steps: steps, child: ActualMainPage(focusNodes: focusNodes, steps: steps, doOnboarding: widget.doOnboarding,));
  }
}

class ActualMainPage extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final List<OnboardingStep> steps;
  final bool doOnboarding;

  const ActualMainPage({
    super.key,
    required this.focusNodes,
    required this.steps,
    required this.doOnboarding
  });

  @override
  State<ActualMainPage> createState() => _ActualMainPageState();
}

class _ActualMainPageState extends LifecycleWatcherState<ActualMainPage> {
  /// Originally, we didn't use [PageView] at all, but in order to keep alive
  /// some pages, we need to use [AutomaticKeepAliveClientMixin] which in turn
  /// require using [PageView].
  ///
  /// Adapted from: https://stackoverflow.com/a/64057210
  late final PageController _pageController;
  int _pageIndex = 0;
  late final List<Widget> _pages;

  // Use ElevatedButton.styleFrom instead of ButtonStyle: https://stackoverflow.com/questions/66542199/what-is-materialstatepropertycolor
  final bottomNavButtonStyle = ElevatedButton.styleFrom(
    // Without this, the background of the button will not be transparent
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    padding: const EdgeInsets.all(
        0), // To prevent overflow. This is still needed despite with Expanded/Flex
  );

  /// Pre-cache most icons that might load slowly and cause flickering otherwise.
  ///
  /// (Tried caching during [initState] with
  /// [WidgetsBinding.instance.addPostFrameCallback] but it only work sometimes.
  /// So we do it somewhere else.)
  ///
  /// We chose to do it after this page loads (via [didChangeDependencies]), and
  /// on resume (Flutter clears image cache on every paused lifecycle by design:
  /// https://github.com/flutter/flutter/issues/64558#issuecomment-850599243)
  void _precacheIcons() {
    // logo
    precacheImage(const AssetImage("image/header_logo_eng.png"), context);
    // profile pics
    if (UserProfileService().image == null) {
      precacheImage(profilePlaceholder, context);
    } else {
      precacheImage(UserProfileService().image!.image, context);
    }

    // add event
    precacheImage(const AssetImage('image/add_event/add_seizure.png'), context);
    precacheImage(const AssetImage('image/add_event/add_med_allergy.png'), context);
    precacheImage(const AssetImage('image/add_event/add_med.png'), context);
    // wiki
    precacheImage(const AssetImage('image/symptom_icon.png'), context);
    precacheImage(const AssetImage('image/medication_icon.png'), context);
    // seizure info
    for (Symptom symptom in symptomEntries) {
      precacheImage(symptom.icon, context);
    }
    // med
    for (Medication med in medicationEntries) {
      precacheImage(med.icon, context);
    }
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _pageIndex);
    _pages = [
      Home(focusNodes: widget.focusNodes,),
      const Calendar(),
      const Wiki(),
      const Contact(),
    ];

    listenNotification();

    if (widget.doOnboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final onboarding = Onboarding.of(context);
        if (onboarding != null) {
          onboarding.show();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    _precacheIcons();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onResumed() {
    _precacheIcons();
  }
  @override
  /// Do nothing.
  void onDetached() {}
  @override
  /// Do nothing.
  void onInactive() {}
  @override
  /// Do nothing.
  void onPaused() {}

  void listenNotification() =>
      NotificationService.notificationTriggerStream.listen((payload) {
        onClickedNotification(payload);
      });

  /// The only notification that this app sends out is the medication intake
  /// alarm, which we'll handle here.
  void onClickedNotification(String? payload) {
    if (payload != null) {
      Alarm alarmFromNotification = Alarm.fromSerializedString(payload);
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddMedIntakeInput(
              initNotification: alarmFromNotification,
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // To have a gradient background, need to wrap with container
      decoration: baseBackgroundDecoration,
      child: Scaffold(
        endDrawer: const SafeArea(child: HomeDrawer()),
        endDrawerEnableOpenDragGesture: false,
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Focus(
                  focusNode: widget.focusNodes[1],
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pageIndex = 0;
                        _pageController.jumpToPage(_pageIndex);
                      });
                    },
                    style: bottomNavButtonStyle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_pageIndex == 0 ? Icons.home : Icons.home_outlined),
                        Text("หน้าแรก", style: _pageIndex == 0 ? const TextStyle(fontWeight: FontWeight.bold) : null)
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Focus(
                  focusNode: widget.focusNodes[3],
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pageIndex = 1;
                        _pageController.jumpToPage(_pageIndex);
                      });
                    },
                    style: bottomNavButtonStyle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_pageIndex == 1 ? Icons.calendar_month : Icons.calendar_month_outlined),
                        Text("ปฎิทิน", style: _pageIndex == 1 ? const TextStyle(fontWeight: FontWeight.bold) : null)
                      ],
                    ),
                  ),
                ),
              ),
              Focus(
                focusNode: widget.focusNodes[4],
                child: Stack(
                  // alignment: AlignmentDirectional.center,
                  // clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      // top: addButtonOffset.dy,
                      child: RawMaterialButton(
                        // https://stackoverflow.com/questions/49809351/how-to-create-a-circle-icon-button-in-flutter
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddSelect()));
                        },
                        elevation: 2.0,
                        fillColor: const Color(0xffD9ACF5),
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                          size: 35.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Focus(
                  focusNode: widget.focusNodes[5],
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pageIndex = 2;
                        _pageController.jumpToPage(_pageIndex);
                      });
                    },
                    style: bottomNavButtonStyle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_pageIndex == 2 ? Icons.book : Icons.book_outlined),
                        Text("ข้อมูล", style: _pageIndex == 2 ? const TextStyle(fontWeight: FontWeight.bold) : null)
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Focus(
                  focusNode: widget.focusNodes[6],
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pageIndex = 3;
                        _pageController.jumpToPage(_pageIndex);
                      });
                    },
                    style: bottomNavButtonStyle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_pageIndex == 3 ? Icons.headset : Icons.headset_outlined),
                        Text("ติดต่อ", style: _pageIndex == 3 ? const TextStyle(fontWeight: FontWeight.bold) : null)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
        ),
      ),
    );
  }
}
