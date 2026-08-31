import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Discover/blocs/local_search_product_bloc/local_search_product_bloc.dart';
import 'package:Discover/view/details_view.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<LocalSearchProductBloc>().add(
                  SearchEvent(query: value),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xffF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<LocalSearchProductBloc, LocalSearchProductState>(
              builder: (context, state) {
                if (state is LocalSuccess) {
                  return state.products.isEmpty
                      ? Haserror()
                      : ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsView(
                                      product: state.products[index],
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(state.products[index].title),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: CachedNetworkImage(
                                    imageUrl: state.products[index].thumbnail,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } else if (state is LocalError) {
                  return const Center(child: Text("Error occurred"));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Haserror extends StatelessWidget {
  const Haserror({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 150.h),
          Icon(Icons.search, size: 100.sp, color: Color(0xffB3B3B3)),
          Text(
            'No Results Found!',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
          ),
          SizedBox(
            width: 252.w,
            child: Text(
              'Try a similar word or something more general.',
              style: TextStyle(
                color: Color(0xff808080),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
