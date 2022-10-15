import 'dart:io';

import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:ansar_rental/app/utils/service_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:velocity_x/velocity_x.dart';

class BillController extends GetxController implements GetxService {
  final _dbClient = Get.find<FirestoreClient>();
  final formKey = GlobalKey<FormState>();

  final selectedRoomNo = Rx<int?>(null);
  late final TextEditingController electricityNewUnitController,
      electricityOldUnitController,
      waterWasteController,
      roomRentController,
      electricityPricePerUnitController,
      previousDueController;

  late final ScreenshotController screenshotController;

  Stream<List<UserModel>> getAllUsers() => _dbClient.getAllUsers();

  String? notBlankValidator(String? text) {
    if (text?.isBlank ?? true) {
      return 'Required';
    }
    return null;
  }

  Future<UserModel> getUserByRoomId() async {
    final room = selectedRoomNo.string;
    await Get.putAsync(
      () => _dbClient.getUserByRoomNo(room),
      permanent: true,
      tag: room,
    );
    return Get.find<UserModel>(tag: room);
  }

  @override
  void onInit() {
    electricityNewUnitController = TextEditingController();
    electricityOldUnitController = TextEditingController();
    waterWasteController = TextEditingController();
    roomRentController = TextEditingController();
    electricityPricePerUnitController = TextEditingController();
    previousDueController = TextEditingController();
    screenshotController = ScreenshotController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    waterWasteController.dispose();
    electricityNewUnitController.dispose();
    roomRentController.dispose();
    electricityPricePerUnitController.dispose();
    electricityOldUnitController.dispose();
    super.onClose();
  }

  Future<void> _sendFile() async {
    final screenshot = await screenshotController.capture(
      delay: 0.milliseconds,
    );
    final document = pw.Document(
      title: 'Ansar Rental',
      subject: 'Rent for month ${getNepaliMonth()}',
      pageMode: PdfPageMode.outlines,
    );

    final image = pw.MemoryImage(screenshot!);

    document.addPage(
      pw.Page(
        build: (_) => pw.Container(
          child: pw.Column(
            children: [
              pw.Text(
                'Ansar Rental',
                textScaleFactor: 3,
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Rent for month ${getNepaliMonth()}',
                textScaleFactor: 2,
              ),
              pw.SizedBox(height: 40),
              pw.Image(image),
              pw.SizedBox(height: 40),
              pw.Text(
                'Please make your payment using online '
                'platforms or visit offline.\nThank you',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  color: PdfColor.fromHex(Vx.grayHex400),
                ),
              ),
              pw.SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/ansar_bill.pdf');

    final savedPdf = await document.save();

    await file.writeAsBytes(savedPdf);

    final receiver = await getUserByRoomId();

    final email = Email(
      subject: 'Ansar Rental bill for ${getNepaliMonth()}',
      body: 'Please clear the bill as soon as possible',
      recipients: [receiver.email],
      attachmentPaths: [file.path],
    );
    await FlutterEmailSender.send(email);
  }

  Future<void> onSendPress() => callService(
        _sendFile,
        onSuccess: () => Get
          ..back<dynamic>()
          ..snackbar(
            'Success',
            'Successfully sent',
            snackPosition: SnackPosition.BOTTOM,
          ),
        onFailure: (error) => Get
          ..back<dynamic>()
          ..snackbar(
            'Something went wrong',
            'Please retry',
            snackPosition: SnackPosition.BOTTOM,
          ),
      );

  String? getNepaliMonth() => [
        'Baisakh',
        'Jestha',
        'Ashad',
        'Shrawan',
        'Bhadra',
        'Kartik',
        'Mangshir',
        'Poush',
        'Magh',
        'Falgun',
        'Chaitra',
      ].asMap()[DateTime.now().month];

  final _formatter = NumberFormat('##,##,###');

  String getRoomRent() =>
      'Rs. ${_formatter.format(int.parse(roomRentController.text))}';

  String getWaterAndWaste() =>
      'Rs. ${_formatter.format(int.parse(waterWasteController.text))}';

  String getPreviousDue() {
    final due = int.tryParse(previousDueController.text);

    if (due == null) {
      return 'No Due';
    }

    return 'Rs. ${_formatter.format(due)}';
  }

  String getConsumedUnits() {
    final oldUnit = int.parse(electricityOldUnitController.text);
    final newUnit = int.parse(electricityNewUnitController.text);
    return _formatter.format(newUnit - oldUnit);
  }

  String getTotalElectricityAmount() {
    final oldUnit = int.parse(electricityOldUnitController.text);
    final newUnit = int.parse(electricityNewUnitController.text);
    final pricePerUnit = int.parse(electricityPricePerUnitController.text);

    final total = (newUnit - oldUnit) * pricePerUnit;
    return 'Rs. ${_formatter.format(total)}';
  }

  String getTotalAmount() {
    final roomRent = int.parse(roomRentController.text);

    final newUnit = int.parse(electricityNewUnitController.text);
    final oldUnit = int.parse(electricityOldUnitController.text);

    final totalUnit = newUnit - oldUnit;

    final pricePerUnit = int.parse(electricityPricePerUnitController.text);
    final waterAndWaste = int.parse(waterWasteController.text);

    final previousDue = int.tryParse(previousDueController.text) ?? 0;

    final total =
        roomRent + (totalUnit * pricePerUnit) + waterAndWaste + previousDue;

    return 'Rs. ${_formatter.format(total)}';
  }
}
