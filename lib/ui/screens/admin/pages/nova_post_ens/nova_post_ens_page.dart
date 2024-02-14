import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/all_products/all_products_effects.dart';
import 'package:moxy/domain/admin/create_order/create_order_cubit.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_cubit.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_effects.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_state.dart';
import 'package:moxy/domain/models/nova_en.dart';

import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NovaPostENsPage extends StatefulWidget {
  const NovaPostENsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NovaPostENsPageState createState() => _NovaPostENsPageState();
}

class _NovaPostENsPageState extends State<NovaPostENsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSearchVisible = true;
  late NovaPostENsCubit _ensCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final createOrderCubit = context.read<CreateOrderCubit>();
    _ensCubit = NovaPostENsCubit(orderCubit: createOrderCubit);
    _ensCubit.effectStream.listen((effect) {
      if (effect is ProductsLoadingFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                '${AppLocalizations.of(context)!.productsLoadingFailed} ${effect.failureText}'));
      } else if (effect is ApiKeyNotSaved) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                AppLocalizations.of(context)!.novaPostNoApiKeyEnter));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isSearchVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isSearchVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NovaPostENsCubit>(
      create: (BuildContext context) => _ensCubit,
      child: BlocBuilder<NovaPostENsCubit, NovaPostENsState>(
        builder: (context, state) {
          final apiKey = state.savedNovaPostApiKey ?? '';
          final theme = AppTheme.of(context)!;

          return Scaffold(
            body: Material(
              color: AppTheme.pink,
              child: Stack(
                children: [
                  _buildLoadingIfNeeded(state),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _ensCubit.refreshAllENs();
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: AppTheme.pink,
                            surfaceTintColor: AppTheme.pink,
                            floating: true,
                            pinned: false,
                            snap: true,
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _isSearchVisible
                                      ? SearchTextfield(
                                          title: AppLocalizations.of(context)!
                                              .search,
                                          onChanged: (term) =>
                                              _ensCubit.searchProducts(term),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Text(
                                      'API key: $apiKey',
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.smallSemiBoltText,
                                    ),
                                    onTap: () => _displayApiKeyDialog(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: state.allENs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = state.allENs[index];
                                  return _ENsItem(item: item);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIfNeeded(NovaPostENsState state) {
    return state.isLoading
        ? const LinearProgressIndicator(
            color: AppTheme.pinkDark,
            backgroundColor: AppTheme.pink,
          )
        : Container();
  }

  Future<void> _displayApiKeyDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.novaPostNoApiKeyEnter),
            content: TextField(
              onChanged: (String value) {
                _ensCubit.onApiKeyTextChanged(value);
              },
              controller: _ensCubit.apiKeyController,
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  _ensCubit.submitNovaPostApiKey(
                      _ensCubit.state.savedNovaPostApiKey);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

class _ENsItem extends StatelessWidget {
  final NovaEN item;
  const _ENsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NovaPostENsCubit>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(14.0),
        onTap: () {
          cubit.loadENsData(item);
          context.pop();
        },
        tileColor: AppTheme.white,
        title: Text(item.recipientContactPerson),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.recipientPhone),
              ],
            ),
            Text(
              item.cityRecipientDescription,
              maxLines: 2,
            ),
          ],
        ),
        trailing: SvgPicture.asset(IconPath.forwardArrow),
      ),
    );
  }
}
