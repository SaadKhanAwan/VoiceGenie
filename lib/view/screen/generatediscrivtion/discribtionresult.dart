import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:zenithrabitai/model/chatbot_model.dart';
import 'package:zenithrabitai/utils/sizebox.dart';
import 'package:zenithrabitai/utils/space.dart';
import 'package:zenithrabitai/viewmodel/controller/animationContoller/animation_conroller.dart';
import 'package:zenithrabitai/viewmodel/controller/copytext/copyit.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/chatbot/generatetext.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/image_picker/image_picker.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/speech_text/speech_text.dart';
import 'package:zenithrabitai/viewmodel/controller/text_audio/text_audio.dart';
import 'package:zenithrabitai/viewmodel/services/chatbot/generate_text_image.dart';
import 'dart:math' as math;
import 'package:zenithrabitai/viewmodel/services/chatbot/generate_text_only.dart';

class DiscribtionRresult extends StatefulWidget {
  const DiscribtionRresult({super.key});

  @override
  State<DiscribtionRresult> createState() => _DiscribtionRresultState();
}

class _DiscribtionRresultState extends State<DiscribtionRresult>
    with TickerProviderStateMixin {
  File? photo;
  String? text;
  String? mytext;
  TextEditingController controller = TextEditingController();
  SpeechToText speechToText = SpeechToText();
  bool isavalible = false;

  @override
  void initState() {
    super.initState();
    MyAnimation.animationcontroller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<SpeachToTextProvider>(context);
    provider.initSpeech();
  }

  @override
  void dispose() {
    MyAnimation.animationcontroller?.dispose();
    super.dispose();
  }

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: const Color(0xffFFFFFF),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Pixels.width(context, .05)),
                child: Column(
                  children: [
                    const VerticalSizeBox(
                      height: .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "VoiceGenie",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Image.asset("assets/images/profile.png"),
                      ],
                    ),
                    const VerticalSizeBox(
                      height: .05,
                    ),
                    Consumer<GenerateTextProvider>(
                        builder: (context, textProvider, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: textProvider.mylist.length,
                        itemBuilder: (context, index) {
                          ChatBotModel mymodel = textProvider.mylist[index];
                          mymodel.istrue
                              ? MyAnimation.startAnimation()
                              : MyAnimation.stopAnimation();
                          return Column(
                            crossAxisAlignment: mymodel.istrue == true
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Pixels.width(context, .02),
                                      vertical: Pixels.height(context, .03)),
                                  decoration: BoxDecoration(
                                      borderRadius: mymodel.istrue
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))
                                          : null,
                                      color: mymodel.istrue &&
                                              mymodel.image != null
                                          ? const Color(0xffEAEDF8)
                                          : mymodel.istrue
                                              ? const Color(0xffFFEFE1)
                                              : Colors.transparent),
                                  child: mymodel.istrue && mymodel.image != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mymodel.text!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                mymodel.image!,
                                                height:
                                                    Pixels.height(context, .3),
                                                width:
                                                    Pixels.width(context, .44),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          ],
                                        )
                                      : mymodel.istrue == false
                                          ? AnimatedTextKit(
                                              animatedTexts: [
                                                TypewriterAnimatedText(
                                                  "${mymodel.text}",
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  speed: const Duration(
                                                      milliseconds: 20),
                                                ),
                                              ],
                                              isRepeatingAnimation: false,
                                              pause: const Duration(seconds: 3),
                                              displayFullTextOnTap: false,
                                              stopPauseOnTap: false,
                                            )
                                          : Text(
                                              "${mymodel.text}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                              const VerticalSizeBox(height: .01),
                              mymodel.istrue
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          mymodel.istrue
                                              ? AnimatedBuilder(
                                                  animation: MyAnimation
                                                      .animationcontroller!,
                                                  child: const Center(
                                                    child: Image(
                                                        image: AssetImage(
                                                            'images/virus.png')),
                                                  ),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Transform.rotate(
                                                      angle: MyAnimation
                                                                  .isAnimating &&
                                                              index ==
                                                                  textProvider
                                                                          .mylist
                                                                          .length -
                                                                      1
                                                          ? MyAnimation
                                                                  .animationcontroller!
                                                                  .value *
                                                              2.0 *
                                                              math.pi
                                                          : 0,
                                                      child: Image.asset(
                                                          "assets/images/Logo.png"),
                                                    );
                                                  })
                                              : Image.asset(
                                                  "assets/images/Logo.png"),
                                        ])
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              if (mymodel.istrue == false) {
                                                text = mymodel.text;
                                              }
                                              CopyIt.copyToClipboard(
                                                  textToCopy: text,
                                                  context: context);
                                            },
                                            child:
                                                const Icon(Icons.copy_sharp)),
                                        GestureDetector(
                                          onTap: () {
                                            if (mymodel.istrue == false) {
                                              text = mymodel.text;
                                              TextToAudio.speak(
                                                  text.toString());
                                            }
                                          },
                                          child: const Icon(
                                            Icons.volume_up,
                                          ),
                                        ),
                                      ],
                                    ),
                              const VerticalSizeBox(
                                height: .03,
                              ),
                            ],
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
            )),
            Container(
              height: 3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                    color: Colors.grey.shade400,
                  )
                ],
              ),
            ),
            Consumer<MyImagePicker>(builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Pixels.width(context, .05),
                            top: Pixels.height(context, .01)),
                        child: provider.image == null
                            ? null
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: provider.image == null
                                    ? null
                                    : Image.file(
                                        provider.image!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                              ),
                      ),
                      Positioned(
                          top: 20,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              provider.removeImage();
                            },
                            child: const Icon(
                              CupertinoIcons.clear_circled,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              );
            }),
            buildLowerBody()
          ],
        ),
      ),
    );
  }

  Widget buildLowerBody() {
    final chatDataProvider =
        Provider.of<GenerateTextProvider>(context, listen: false);
    final imagePicker = Provider.of<MyImagePicker>(context, listen: false);
    return Column(
      children: [
        Container(
          color: const Color(0xffFFFFFF),
          padding: const EdgeInsets.only(
            left: 10,
            top: 5,
          ),
          child: Container(
              // this is for inner padding of cantainer
              padding: EdgeInsets.symmetric(
                horizontal: Pixels.width(context, .02),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), border: null),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.streetAddress,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type talk or share a photo"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<SpeachToTextProvider>(
                          builder: (context, provider, child) {
                        return GestureDetector(
                          onTapDown: (value) async {
                            if (provider.recordingStart == false) {
                              await provider.startListening(
                                  controller: controller);
                            }
                          },
                          onTapUp: (value) async {
                            if (provider.recordingStart == true) {
                              provider.stopListening();
                            }
                          },
                          child: AvatarGlow(
                              startDelay: const Duration(milliseconds: 150),
                              glowColor: Colors.brown,
                              glowShape: BoxShape.circle,
                              animate: provider.recordingStart,
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                  height: 40,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: const Color.fromARGB(
                                          255, 167, 121, 82)),
                                  child: const Icon(Icons.mic))),
                        );
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            imagePicker.pickImage();
                          },
                          child: Container(
                              height: 40,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: const Color(0xffFFDCBD),
                              ),
                              child: const Icon(Icons.camera_alt))),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (controller.text.isNotEmpty ||
                                imagePicker.image != null) {
                              if (imagePicker.image == null) {
                                ChatBotText.generateText(
                                    controller.text, context);
                                controller.clear();

                                FocusScope.of(context).unfocus();
                              } else {
                                chatDataProvider.addMessage(
                                    true, controller.text, imagePicker.image);

                                ChatBotWithImage.getdata(imagePicker.image,
                                    controller.text, context);
                                controller.clear();
                                FocusScope.of(context).unfocus();
                                photo = imagePicker.image;
                                imagePicker.removeImage();
                              }
                            }
                          },
                          child: Icon(Icons.send,
                              color: controller.text.isNotEmpty ||
                                      imagePicker.image != null
                                  ? Colors.blue
                                  : Colors.grey)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )),
        )
      ],
    );
  }
}
