import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

class EmbedsFormField<T> extends FormField<List<T>> {
  EmbedsFormField({
    super.key,
    required super.builder,
    List<T>? initialValue,
    super.validator,
  }) : super(
          initialValue: initialValue != null ? List.from(initialValue) : null,
        );

  @override
  FormFieldState<List<T>> createState() => _EmbedsFormFieldState();
}

class _EmbedsFormFieldState<T> extends FormFieldState<List<T>> {}
