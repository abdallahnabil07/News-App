part of 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  /// Use case responsible for fetching news articles from repository/API
  final GetNewsUseCase getNewsUseCase;

  NewsCubit(this.getNewsUseCase) : super(InitialNewsState());

  /// Current search query entered by user
  String _searchQuery = "";

  String get searchQuery => _searchQuery;

  /// Full list of fetched articles (unfiltered)
  List<ArticlesDataModel> _articles = [];

  /// Filtered list used during search
  List<ArticlesDataModel> _filteredArticles = [];

  /// Returns either full or filtered list depending on search mode
  List<ArticlesDataModel> get articles =>
      _isSearching ? _filteredArticles : _articles;

  /// Pagination state
  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  /// Currently selected news source
  String _currentSourceId = '';

  // ====================== ARTICLES ======================

  /// Retry last failed request
  Future<void> retry() async {
    await getAllArticles(sourceId: _currentSourceId, page: 1);
  }

  /// Fetch articles for a specific source
  ///
  /// Supports pagination:
  /// - page = 1 → fresh load
  /// - page > 1 → append results
  Future<void> getAllArticles({
    String sourceId = "",
    int page = 1,
  }) async {
    if (sourceId.isEmpty) return;

    _currentSourceId = sourceId;

    try {
      // Emit loading state depending on page type
      if (page == 1) {
        emit(NewsLoading());
      } else {
        isLoadingMore = true;
        emit(NewsLoadingMore());
      }

      final response = await getNewsUseCase(sourceId, page: page);
      // Replace or append articles
      if (page == 1) {
        _articles = response;
      } else {
        _articles.addAll(response);
      }

      // Update pagination state
      this.page = page;
       hasMore = response.isNotEmpty;

      emit(NewsLoaded());
    } catch (error) {
      // Handle API/network errors
      if (error is NetworkException) {
        emit(NewsError(failedMessage: error.message));
      } else {
        emit(NewsError(
          failedMessage: AppStrings.somethingWentWrong,
        ));
      }
    } finally {
      isLoadingMore = false;
    }
  }

  // ====================== PAGINATION ======================

  /// Refresh articles list (pull-to-refresh)
  Future<void> refresh() async {
    page = 1;
    hasMore = true;
    _articles = [];

    emit(NewsLoading());

    await getAllArticles(
      page: 1,
      sourceId: _currentSourceId,
    );
  }

  /// Load next page of articles
  ///
  /// Prevents duplicate calls if:
  /// - already loading
  /// - no more data available
  /// - search mode is active
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore || _isSearching) return;
    if (state is NewsLoadingMore) return;
    await getAllArticles(
      page: page + 1,
      sourceId: _currentSourceId,
    );
  }

  // ====================== SEARCH ======================

  /// Indicates whether search mode is active
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  /// Enable search mode and prepare filtered list
  void startSearch() {
    _isSearching = true;
    _filteredArticles = List.from(_articles);
    emit(NewsSearching());
  }

  /// Disable search and reset state
  void stopSearch() {
    _isSearching = false;
    _searchQuery = '';
    _filteredArticles.clear();
    emit(NewsLoaded());
  }

  /// Filter articles based on search query
  void onSearch(String query) {
    _searchQuery = query;
    _isSearching = query.isNotEmpty;

    if (_isSearching) {
      _filteredArticles = _articles
          .where(
            (article) =>
            article.title
                .toLowerCase()
                .contains(query.toLowerCase()),
      )
          .toList();
    } else {
      _filteredArticles = List.from(_articles);
    }

    emit(NewsLoaded());
  }
}