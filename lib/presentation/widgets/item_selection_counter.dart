import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/presentation/providers/user_data_provider.dart';

class ItemSelectionCounter extends ConsumerWidget {
  const ItemSelectionCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Set<int> ids = ref.watch(selectedIdsProvider);
    return ids.isEmpty
        ? SizedBox()
        : InkWell(
            onTap: () {
              ref.read(selectedIdsProvider.notifier).state = Set<int>();
            },
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              width: 35,
              child: Center(
                child: Text(
                  "${ids.length}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
  }
}
