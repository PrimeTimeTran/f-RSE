import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitialized extends AssetEvent {
  final Asset asset;

  AssetInitialized(this.asset);

  @override
  List<Object?> get props => [asset];
}

class AssetErrored extends AssetEvent {}

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitial extends AssetState {
  final Asset asset;

  AssetInitial(this.asset);

  @override
  List<Object?> get props => [asset];
}

class AssetLoading extends AssetState {}

class AssetLoaded extends AssetState {
  final Asset asset;

  AssetLoaded(this.asset);

  @override
  List<Object?> get props => [asset];
}

class AssetError extends AssetState {
  final String errorMessage;

  AssetError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  late Asset asset;
  String sym = 'GOOGL';
  String period = 'live';
  final AssetService assetService;

  AssetBloc({required this.asset, required this.assetService})
      : super(AssetInitial(asset)) {
    on<AssetInitialized>((event, emit) async {
      emit(AssetLoaded(event.asset));
    });
    on<AssetErrored>((error, emit) async {
      emit(AssetError('Error'));
    });
  }

  void fetchAsset(String sym) async {
    try {
      final Asset newAsset = await assetService.fetchAsset(sym, period);
      asset = newAsset;
      add(AssetInitialized(newAsset));
    } catch (e) {
      add(AssetErrored());
    }
  }

  void setPeriod(String p) async {
    period = p;
    fetchAsset(asset.sym);
  }
}
