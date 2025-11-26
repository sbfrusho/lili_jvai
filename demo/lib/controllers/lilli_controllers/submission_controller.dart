import 'package:get/get.dart';
import 'package:demo/models/lilli_models/submission_model.dart';

class SubmissionController extends GetxController {
  RxList<SubmissionModel> submissions = <SubmissionModel>[].obs;
  void onInit() {
    super.onInit();

    // 🟢 Add dummy submissions here
    submissions.addAll([
      SubmissionModel(source: "Bone", known: "Bon", category: "Body Parts"),
      SubmissionModel(source: "Hello", known: "Yokwe", category: "General"),
      SubmissionModel(source: "Water", known: "Wotah", category: "Essentials"),
    ]);
  }

  void addSubmission(SubmissionModel submission) {
    submissions.add(submission);
  }

  void removeSubmission(SubmissionModel submission) {
    submissions.remove(submission);
  }
}
