import 'package:flutter/material.dart';

class ReorderableItemRecord<T> {
  final T value;
  final String label;

  ReorderableItemRecord({
    required this.value,
    required this.label,
  });
}

class ReorderableAddRemoveList<T> extends StatefulWidget {
  final List<ReorderableItemRecord<T>> itemOptions;

  final ReorderableItemRecord<T> Function(int index) builder;

  final void Function(T value) addItem;
  final void Function(int oldIndex, int newIndex) moveItem;
  final void Function(int index) removeItem;

  final int itemCount;

  const ReorderableAddRemoveList({
    super.key,
    required this.itemOptions,
    required this.builder,
    required this.addItem,
    required this.moveItem,
    required this.removeItem,
    required this.itemCount,
  });

  @override
  State<ReorderableAddRemoveList<T>> createState() =>
      _ReorderableAddRemoveListState<T>();
}

class _ReorderableAddRemoveListState<T>
    extends State<ReorderableAddRemoveList<T>> {
  ReorderableItemRecord<T>? selected;

  late TextEditingController _dropdownMenuTextController;

  @override
  void initState() {
    super.initState();
    _dropdownMenuTextController = TextEditingController();
  }

  @override
  void dispose() {
    _dropdownMenuTextController.dispose();
    super.dispose();
  }

  void _unselect() {
    selected = null;
    _dropdownMenuTextController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<ReorderableItemRecord<T>?>> entries = [
      const DropdownMenuEntry(value: null, label: ""),
    ];
    entries.addAll(
      widget.itemOptions.map(
        (e) => DropdownMenuEntry(value: e, label: e.label),
      ),
    );

    if (selected != null &&
        !widget.itemOptions.any((e) => e.value == selected!.value)) {
      _unselect();
    }

    Widget addEmbedButton = IconButton(
      icon: const Icon(Icons.add_circle_outline),
      onPressed: selected != null
          ? () {
              widget.addItem(selected!.value);
              _unselect();
            }
          : null,
    );
    if (selected != null) {
      addEmbedButton = Tooltip(
        message: selected != null ? "Add Embed: ${selected!.label}" : null,
        child: addEmbedButton,
      );
    }

    return Column(
      children: [
        Row(
          children: [
            DropdownMenu<ReorderableItemRecord<T>?>(
              controller: _dropdownMenuTextController,
              width: MediaQuery.sizeOf(context).width / 2,
              dropdownMenuEntries: entries,
              hintText: "Choose embed",
              onSelected: (value) => setState(() => selected = value),
            ),
            addEmbedButton,
          ],
        ),
        ReorderableListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final ReorderableItemRecord<T> item = widget.builder(index);

            return ListTile(
              key: Key("reordAddRmv_$index"),
              title: Text(item.label),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.red,
                onPressed: () => widget.removeItem(index),
              ),
            );
          },
          itemCount: widget.itemCount,
          onReorder: widget.moveItem,
        ),
      ],
    );
  }
}
