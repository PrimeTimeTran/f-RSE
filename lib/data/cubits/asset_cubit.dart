import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/services/all.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAsset extends AssetEvent {
  final String id;

  FetchAsset(this.id);

  @override
  List<Object?> get props => [id];
}

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitial extends AssetState {}

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

class AssetCubit extends Cubit<AssetState> {
  List<CandleStick> live = [];
  final AssetService assetService = AssetService();

  AssetCubit() : super(AssetInitial());

  Future<void> fetchAsset(String id) async {
    emit(AssetLoading());

    try {
      final p = await assetService.fetchAsset(id);
      live = p.live;
      emit(AssetLoaded(p));
    } catch (e) {
      emit(AssetError('Error fetching asset'));
    }
  }
}
