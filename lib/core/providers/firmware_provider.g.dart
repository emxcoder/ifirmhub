// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firmwaresHash() => r'09cdfbb2896031e82ba5d252413c25d74ff31f62';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [firmwares].
@ProviderFor(firmwares)
const firmwaresProvider = FirmwaresFamily();

/// See also [firmwares].
class FirmwaresFamily extends Family<AsyncValue<List<FirmwareModel>>> {
  /// See also [firmwares].
  const FirmwaresFamily();

  /// See also [firmwares].
  FirmwaresProvider call(
    String identifier,
    String type,
  ) {
    return FirmwaresProvider(
      identifier,
      type,
    );
  }

  @override
  FirmwaresProvider getProviderOverride(
    covariant FirmwaresProvider provider,
  ) {
    return call(
      provider.identifier,
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'firmwaresProvider';
}

/// See also [firmwares].
class FirmwaresProvider extends AutoDisposeFutureProvider<List<FirmwareModel>> {
  /// See also [firmwares].
  FirmwaresProvider(
    String identifier,
    String type,
  ) : this._internal(
          (ref) => firmwares(
            ref as FirmwaresRef,
            identifier,
            type,
          ),
          from: firmwaresProvider,
          name: r'firmwaresProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$firmwaresHash,
          dependencies: FirmwaresFamily._dependencies,
          allTransitiveDependencies: FirmwaresFamily._allTransitiveDependencies,
          identifier: identifier,
          type: type,
        );

  FirmwaresProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.identifier,
    required this.type,
  }) : super.internal();

  final String identifier;
  final String type;

  @override
  Override overrideWith(
    FutureOr<List<FirmwareModel>> Function(FirmwaresRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FirmwaresProvider._internal(
        (ref) => create(ref as FirmwaresRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        identifier: identifier,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FirmwareModel>> createElement() {
    return _FirmwaresProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FirmwaresProvider &&
        other.identifier == identifier &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, identifier.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FirmwaresRef on AutoDisposeFutureProviderRef<List<FirmwareModel>> {
  /// The parameter `identifier` of this provider.
  String get identifier;

  /// The parameter `type` of this provider.
  String get type;
}

class _FirmwaresProviderElement
    extends AutoDisposeFutureProviderElement<List<FirmwareModel>>
    with FirmwaresRef {
  _FirmwaresProviderElement(super.provider);

  @override
  String get identifier => (origin as FirmwaresProvider).identifier;
  @override
  String get type => (origin as FirmwaresProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
