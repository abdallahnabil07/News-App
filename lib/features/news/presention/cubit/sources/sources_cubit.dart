part of 'sources_state.dart';

@injectable
class SourcesCubit extends Cubit<SourcesState> {
  final GetSourcesUseCase getSourcesUseCase;

  SourcesCubit(this.getSourcesUseCase) : super(InitialSourcesState());
  List<SourceData> _sourceData = [];
  int _selectedTapIndex = 0;

  int get currentIndex => _selectedTapIndex;

  List<SourceData> get sourceData => _sourceData;

  // get sources
  Future<void> getAllSources(String categoryId) async {
    try {
      emit(SourcesLoading());
      _sourceData = await getSourcesUseCase(categoryId);

      _selectedTapIndex = 0;

      emit(SourcesLoaded(sources: _sourceData));
    } catch (error) {
      emit(SourcesError(failedMessage: error.toString()));
    }
  }

  // tap on sources
  void changeTab(int index) {
    _selectedTapIndex = index;
    emit(SourcesTabChanged());
  }
}
