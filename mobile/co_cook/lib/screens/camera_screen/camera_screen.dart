import 'dart:io';
import 'package:co_cook/services/image_service.dart';
import 'package:camera/camera.dart';
import 'package:co_cook/screens/camera_screen/widgets/camera_result.dart';
import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/shadows.dart';
import 'package:co_cook/styles/text_styles.dart';
import 'package:co_cook/utils/route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.setWordAndSearch});
  final Function setWordAndSearch;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  bool isCameraInitialized = false;
  bool isProcess = false;
  late String tmpImgPath;
  XFile? imgFile;

  void _getTmpImgPath() async {
    Directory tmpPath = await getTemporaryDirectory();
    tmpImgPath = '${tmpPath.path}/searchImageFile/${DateTime.now()}.png';
  }

  Future<void> _takePhoto() async {
    _cameraController.pausePreview();
    imgFile = await _cameraController.takePicture();
    setState(() {
      isProcess = true;
    });
    await Future.delayed(Duration(seconds: 1));
    bool state = await getImgData();
    if (state) {
      Navigator.pop(context);
    } else {
      _searchFail();
    }
  }

  Future<void> _selectPhoto() async {
    _cameraController.pausePreview();
    setState(() {
      isProcess = true;
    });
    imgFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      print('이미지 검색 중');
      bool state = await getImgData();
      print(state);
      if (state) {
        Navigator.pop(context);
      } else {
        _searchFail();
      }
    } else {
      _searchCancel();
    }
  }

  void _searchFail() {
    _cameraController.resumePreview();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("인식 실패"),
      duration: Duration(seconds: 1),
    ));
    setState(() {
      isProcess = false;
    });
  }

  void _searchCancel() {
    _cameraController.resumePreview();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("사진 검색이 취소되었습니다"),
      duration: Duration(seconds: 1),
    ));
    setState(() {
      isProcess = false;
    });
  }

  Future _checkAvailableCameras() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    await _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _cameraController.setFocusMode(FocusMode.auto);
      setState(() {
        isCameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            Navigator.pop(context);
            break;
          default:
            // Handle other errors here.
            Navigator.pop(context);
            break;
        }
      }
    });
  }

  Future<bool> getImgData() async {
    String fileName = imgFile!.path.split('/').last;
    MultipartFile multipartFile =
        await MultipartFile.fromFile(imgFile!.path, filename: fileName);
    print(fileName);

    FormData formData = FormData.fromMap({
      "image": multipartFile,
    });

    // API 요청
    ImageService searchService = ImageService();
    Response? response = await searchService.postImage(formData);
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$response');
    if (response?.statusCode == 200) {
      if (response!.data != null) {
        setState(() {
          widget.setWordAndSearch(response.data);
        });
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getTmpImgPath();
    _checkAvailableCameras();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(children: [
          isCameraInitialized
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: isProcess && imgFile != null
                      ? Image.file(
                          width: double.infinity,
                          height: double.infinity,
                          File(imgFile!.path),
                          fit: BoxFit.cover,
                        )
                      : CameraPreview(_cameraController))
              : Container(),
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: 300),
                    width: MediaQuery.sizeOf(context).width *
                        (isProcess ? 0.7 : 0.8),
                    height: MediaQuery.sizeOf(context).width *
                        (isProcess ? 0.7 : 0.8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isProcess
                          ? Border.all(
                              color: Color.fromARGB(67, 0, 0, 0),
                              width: MediaQuery.sizeOf(context).height / 2,
                              strokeAlign: BorderSide.strokeAlignOutside)
                          : Border.all(
                              color: CustomColors.monotoneLight,
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(isProcess ? "인식중입니다" : "찾고싶은 음식을 보여주세요",
                        style: CustomTextStyles().subtitle1.copyWith(
                            color: CustomColors.monotoneLight,
                            shadows: [CustomShadows.text])),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 40,
              bottom: 40,
              child: SafeArea(
                child: ZoomTapAnimation(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(53, 0, 0, 0),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: CustomColors.redLight,
                      ),
                    )),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: SafeArea(
                child: isProcess
                    ? Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            color: CustomColors.monotoneLight))
                    : ZoomTapAnimation(
                        onTap: () => _takePhoto(),
                        child: const Icon(
                          Icons.circle,
                          size: 60,
                          color: CustomColors.redLight,
                        )),
              )),
          Positioned(
              left: 40,
              bottom: 40,
              child: SafeArea(
                child: ZoomTapAnimation(
                    onTap: () => isProcess ? null : _selectPhoto(),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(53, 0, 0, 0),
                      ),
                      child: Icon(
                        Icons.photo_library_outlined,
                        size: 24,
                        color: isProcess
                            ? CustomColors.monotoneGray
                            : CustomColors.redLight,
                      ),
                    )),
              )),
        ]);
      }),
    );
  }
}
