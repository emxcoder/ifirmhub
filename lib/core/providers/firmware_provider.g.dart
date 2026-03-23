// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firmwares)
const firmwaresProvider = FirmwaresFamily._();

final class FirmwaresProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FirmwareModel>>,
          List<FirmwareModel>,
          FutureOr<List<FirmwareModel>>
        >
    with
        $FutureModifier<List<FirmwareModel>>,
        $FutureProvider<List<FirmwareModel>> {
  const FirmwaresProvider._({
    required FirmwaresFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'firmwaresProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$firmwaresHash();

  @override
  String toString() {
    return r'firmwaresProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<FirmwareModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FirmwareModel>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return firmwares(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FirmwaresProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firmwaresHash() => r'09cdfbb2896031e82ba5d252413c25d74ff31f62';

final class FirmwaresFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<FirmwareModel>>,
          (String, String)
        > {
  const FirmwaresFamily._()
    : super(
        retry: null,
        name: r'firmwaresProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FirmwaresProvider call(String identifier, String type) =>
      FirmwaresProvider._(argument: (identifier, type), from: this);

  @override
  String toString() => r'firmwaresProvider';
}
