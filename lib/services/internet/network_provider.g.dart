// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkServiceHash() => r'3d0dfe86aed87515f3d6841a2f09a5594b1d8e75';

/// See also [networkService].
@ProviderFor(networkService)
final networkServiceProvider = AutoDisposeProvider<NetworkService>.internal(
  networkService,
  name: r'networkServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkServiceRef = AutoDisposeProviderRef<NetworkService>;
String _$internetStatusHash() => r'90868501b4a654331a26723fd468acd0a4824359';

/// See also [internetStatus].
@ProviderFor(internetStatus)
final internetStatusProvider = AutoDisposeStreamProvider<bool>.internal(
  internetStatus,
  name: r'internetStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InternetStatusRef = AutoDisposeStreamProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
