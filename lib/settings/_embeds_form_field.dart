import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/widgets/reorderable_add_remove_list.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

class EmbedsFormField extends FormField<UnmodifiableListView<Embed>> {
  final void Function(List<Embed>? list)? onChanged;

  const EmbedsFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    this.onChanged,
    super.validator,
  }) : super(builder: _buildFormField);

  @override
  FormFieldState<UnmodifiableListView<Embed>> createState() =>
      _EmbedsFormFieldState();
}

class _EmbedsFormFieldState
    extends FormFieldState<UnmodifiableListView<Embed>> {
  @override
  EmbedsFormField get widget => super.widget as EmbedsFormField;

  @override
  void didChange(UnmodifiableListView<Embed>? value) {
    super.didChange(value);

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}

Widget _buildFormField(FormFieldState<UnmodifiableListView<Embed>> state) {
  return ReorderableAddRemoveList<Embed>(
    itemOptions: Embed.allEmbeds
        .map((e) => ReorderableItemRecord(value: e, label: e.name))
        .toList(),
    addItem: (val) {
      final List<Embed> list = List.from(state.value ?? const Iterable.empty());
      list.add(val);
      state.didChange(UnmodifiableListView(list));
    },
    moveItem: (oldIndex, newIndex) {
      final List<Embed> list = List.from(state.value ?? const Iterable.empty());
      final Embed removed = list.removeAt(oldIndex);
      list.insert(newIndex, removed);
      state.didChange(UnmodifiableListView(list));
    },
    removeItem: (index) {
      final List<Embed> list = List.from(state.value ?? const Iterable.empty());
      list.removeAt(index);
      state.didChange(UnmodifiableListView(list));
    },
    itemCount: state.value?.length ?? 0,
    builder: (index) {
      final Embed item = state.value![index];
      return ReorderableItemRecord(value: item, label: item.name);
    },
  );
}
