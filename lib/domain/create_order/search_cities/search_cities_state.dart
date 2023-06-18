import '../../copyable.dart';
import '../../models/city.dart';

class SearchCitiesState implements Copyable<SearchCitiesState> {
  bool isLoading;
  List<City> cityList;
  String? searchTerm;

  SearchCitiesState({
    required this.isLoading,
    required this.cityList,
    required this.searchTerm,
  });

  static SearchCitiesState defaultSearchCitiesState() {
    return SearchCitiesState(
      isLoading: false,
      cityList: [],
      searchTerm: null,
    );
  }

  @override
  SearchCitiesState copyWith({
    bool? isLoading,
    List<City>? cityList,
    String? searchTerm,
  }) {
    return SearchCitiesState(
      isLoading: isLoading ?? this.isLoading,
      cityList: cityList ?? this.cityList,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
