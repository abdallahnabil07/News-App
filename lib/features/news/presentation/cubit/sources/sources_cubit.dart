part of 'sources_state.dart';

@injectable
class SourcesCubit extends Cubit<SourcesState> {
  /// Use case responsible for fetching news sources from API/repository
  final GetSourcesUseCase getSourcesUseCase;

  SourcesCubit(this.getSourcesUseCase) : super(InitialSourcesState());

  /// Cached list of loaded sources
  List<SourceData> _sourceData = [];

  /// Currently selected tab index (source selection)
  int _selectedTapIndex = 0;

  /// Exposes current selected tab index
  int get currentIndex => _selectedTapIndex;

  /// Exposes loaded sources list
  List<SourceData> get sourceData => _sourceData;

  // ====================== PUBLIC API ======================

  /// Fetch sources for a given category (legacy/simple call)
  Future<void> getAllSources(String categoryId) async {
    await _getSources(categoryId: categoryId);
  }

  /// Fetch sources filtered by category + country
  ///
  /// Used when the app needs localized news sources
  Future<void> getSourcesByCategoryAndCountry({
    required String categoryId,
    String? country,
  }) async {
    await _getSources(
      categoryId: categoryId,
      country: country,
    );
  }

  // ====================== INTERNAL LOGIC ======================

  /// Core method responsible for fetching sources from use case
  ///
  /// Handles:
  /// - Loading state
  /// - API call
  /// - Caching result
  /// - Resetting selected tab
  /// - Error handling
  Future<void> _getSources({
    required String categoryId,
    String? country,
  }) async {
    try {
      emit(SourcesLoading());

      // Fetch sources from repository layer
      _sourceData = await getSourcesUseCase(
        categoryId: categoryId,
        country: country,
      );

      // Reset selected tab when new data is loaded
      _selectedTapIndex = 0;

      emit(SourcesLoaded(sources: _sourceData));
    } catch (error) {
      // Handle known network errors
      if (error is NetworkException) {
        emit(SourcesError(failedMessage: error.message));
      } else {
        // Fallback for unexpected errors
        emit(SourcesError(
          failedMessage: AppStrings.somethingWentWrong,
        ));
      }
    }
  }

  // ====================== UI STATE ======================

  /// Updates selected tab index and notifies UI
  void changeTab(int index) {
    _selectedTapIndex = index;
    emit(SourcesTabChanged());
  }
}