part of 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;

  NewsCubit(this.newsRepository) : super(InitialNewsState());
  String _searchQuery = "";

  String get searchQuery => _searchQuery;

  List<ArticlesDataModel> _articles = [];
  List<ArticlesDataModel> _filteredArticles = [];

  List<ArticlesDataModel> get articles =>
      _isSearching ? _filteredArticles : _articles;

  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  String _currentSourceId = ''; // ✅ احفظ الـ sourceId

  // ===== ARTICLES =====

  Future<void> getAllArticles({String sourceId = "", int page = 1}) async {
    if (sourceId.isEmpty) return; // ✅ متعملش request لو فاضي
    _currentSourceId = sourceId; // ✅ احفظه عشان loadMore يستخدمه
    try {
      if (page == 1) {
        emit(NewsLoading());
      } else {
        isLoadingMore = true;
        emit(NewsLoadingMore());
      }

      final response = await newsRepository.getAllNews(sourceId, page: page);

      if (page == 1) {
        _articles = response;
      } else {
        _articles.addAll(response);
      }

      this.page = page;
      hasMore = response.isNotEmpty;

      emit(NewsLoaded());
    } catch (error) {
      emit(NewsError(failedMessage: error.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  // ===== PAGINATION =====

  Future<void> refresh() async {
    page = 1;
    hasMore = true;
    await getAllArticles(page: 1, sourceId: _currentSourceId);
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore || _isSearching) {
      return; // ✅ متعملش loadMore وانت بتسيرش
    }
    await getAllArticles(page: page + 1, sourceId: _currentSourceId);
  }

  // ===== SEARCH =====

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void startSearch() {
    _isSearching = true;
    _filteredArticles = List.from(_articles);
    emit(NewsSearching());
  }

  void stopSearch() {
    _isSearching = false;
    _searchQuery = '';
    _filteredArticles.clear();
    emit(NewsLoaded());
  }

  void onSearch(String query) {
    _searchQuery = query;
    _isSearching = query.isNotEmpty;

    if (_isSearching) {
      _filteredArticles = _articles
          .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredArticles = List.from(_articles);
    }

    emit(NewsLoaded());
  }
}
