import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_packegs/blocs/category_bloc/category_bloc.dart';
import 'package:test_packegs/blocs/product_bloc/product_bloc.dart';

class CategoryChipWidget extends StatelessWidget {
  const CategoryChipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState.status == CategoryStatus.loading) {
          return SizedBox(
            height: 50.h,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (categoryState.status == CategoryStatus.error) {
          return SizedBox(
            height: 50.h,
            child: Center(child: Text('Failed to load categories')),
          );
        }

        final categories = categoryState.categories;
        final selectedSlug = categoryState.selectedCategorySlug;

        return SizedBox(
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildCategoryChip(
                  context,
                  name: 'All',
                  slug: 'all',
                  isSelected: selectedSlug == null || selectedSlug == 'all',
                );
              }

              final category = categories[index - 1];
              return _buildCategoryChip(
                context,
                name: category.name,
                slug: category.slug,
                isSelected: selectedSlug == category.slug,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(
    BuildContext context, {
    required String name,
    required String slug,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        label: Text(name),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            context.read<CategoryBloc>().add(
              SelectCategory(categorySlug: slug),
            );

            context.read<ProductBloc>().add(
              GetProductsByCategory(categorySlug: slug),
            );
          }
        },
        selectedColor: Colors.grey,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontSize: 14.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
