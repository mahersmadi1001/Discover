import 'package:Discover/view/search/wedget/empty_search_result.dart';
import 'package:Discover/view/search/wedget/erorr_loading_state.dart';
import 'package:Discover/view/search/wedget/search_input_widget.dart';
import 'package:Discover/view/search/wedget/search_results_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/local_search_product_bloc/local_search_product_bloc.dart';

class SearchView extends StatefulWidget {
  final String initialQuery;

  const SearchView({super.key, required this.initialQuery});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    context.read<LocalSearchProductBloc>().add(
      SearchEvent(query: widget.initialQuery),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E232C)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchInputWidget(
            controller: _searchController,
            onChanged: (value) {
              context.read<LocalSearchProductBloc>().add(
                SearchEvent(query: value),
              );
            },
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: BlocBuilder<LocalSearchProductBloc, LocalSearchProductState>(
              builder: (context, state) {
                if (state is LocalSuccess) {
                  return state.products.isEmpty
                      ? const EmptySearchResult()
                      : SearchResultsList(products: state.products);
                } else if (state is LocalError) {
                  return const ErrorSearchResult();
                }
                return const LoadingSearchResult();
              },
            ),
          ),
        ],
      ),
    );
  }
}
