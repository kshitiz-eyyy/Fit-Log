
import '../model/library_model.dart';

abstract class LibraryRepo {
  Future<LibraryStateModel> getSynchronizedLibraryData();
}