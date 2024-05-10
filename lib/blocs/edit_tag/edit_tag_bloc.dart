import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_tag/edit_tag_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/search_repository_interface.dart';

class _OnSearch extends EditTagEvent {
  final String fireQuery;

  _OnSearch(this.fireQuery);
}

class EditTagBloc extends Bloc<EditTagEvent, EditTagState>
    with DioExceptionHandlerMixin {
  final ISearchRepository searchRepository;

  EditTagBloc({
    required this.searchRepository,
    List<String>? tags,
  }) : super(EditTagState.init(tags: tags)) {
    on<EditTagChangeQuery>(
      _editTagChangeQueryHandler,
      transformer: restartable(),
    );
    on<_OnSearch>(__onSearchHandler);
    on<EditTagAdd>(_editTagAddHandler);
    on<EditTagRemove>(_editTagRemoveHandler);
  }

  @override
  void onTransition(Transition<EditTagEvent, EditTagState> transition) {
    super.onTransition(transition);

    if (transition.currentState.query != transition.nextState.query) {
      add(_OnSearch(transition.nextState.query!));
    }
  }

  Future<void> _editTagChangeQueryHandler(
    EditTagChangeQuery event,
    Emitter<EditTagState> emit,
  ) async {
    // Duration 동안 쿼리문 변화가 없을 때만 검색 api 호출
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(query: event.query));
  }

  Future<void> __onSearchHandler(
    _OnSearch event,
    Emitter<EditTagState> emit,
  ) async {
    if (event.fireQuery == Strings.nullStr) {
      emit(state.copyWith(queryResult: []));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        var res = await searchRepository.seatchTag(query: event.fireQuery);

        List<String> result = [];
        result.addAll(res.data ?? []);

        if (res.data == null || res.data?.contains(event.fireQuery) == false) {
          result.add(event.fireQuery);
        }

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          queryResult: result,
        ));
      },
      state: state,
      emit: emit,
    );
  }

  Future<void> _editTagAddHandler(
    EditTagAdd event,
    Emitter<EditTagState> emit,
  ) async {
    if (state.tags.contains(event.tag)) return;
    List<String> res = [];
    res
      ..addAll(state.tags)
      ..add(event.tag);
    emit(state.copyWith(
      tags: res,
      query: '',
      queryResult: [],
    ));
  }

  Future<void> _editTagRemoveHandler(
    EditTagRemove event,
    Emitter<EditTagState> emit,
  ) async {
    List<String> res = [];
    for (var tag in state.tags) {
      if (tag != event.tag) {
        res.add(tag);
      }
    }
    emit(state.copyWith(tags: res));
  }
}
