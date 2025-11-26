import 'package:demo/models/lilli_models/ai_submission_model.dart';
import 'package:get/get.dart';

class AiSubmissionController extends GetxController {
  // List of AI submissions
  RxList<AiSubmissionModel> submissions = <AiSubmissionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add dummy submissions
    submissions.addAll([
      AiSubmissionModel(
        source: "Bone",
        known: "Bon",
        category: "Body Parts",
      ),
      AiSubmissionModel(
        source: "Water",
        known: "Wata",
        category: "Essentials",
      ),
      AiSubmissionModel(
        source: "Apple",
        known: "Apel",
        category: "Food",
      ),
      AiSubmissionModel(
        source: "Sun",
        known: "",
        category: "Nature",
      ),
    ]);
  }

  // Add new submission
  void addSubmission(AiSubmissionModel submission) {
    submissions.add(submission);
  }

  // Remove submission
  void removeSubmission(AiSubmissionModel submission) {
    submissions.remove(submission);
  }

  // Clear all submissions (optional)
  void clearAll() {
    submissions.clear();
  }
}
