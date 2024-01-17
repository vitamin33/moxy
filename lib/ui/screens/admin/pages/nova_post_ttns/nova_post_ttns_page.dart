import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/all_products/all_products_effects.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_cubit.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_effects.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_state.dart';

import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NovaPostENsPage extends StatefulWidget {
  const NovaPostENsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NovaPostENsPageState createState() => _NovaPostENsPageState();
}

class _NovaPostENsPageState extends State<NovaPostENsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSearchVisible = true;
  late NovaPostENsCubit cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    cubit = context.read<NovaPostENsCubit>();
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
    final NovaPostENsCubit cubit = context.read<NovaPostENsCubit>();

    cubit.effectStream.listen((effect) {
      if (effect is ProductsLoadingFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                '${AppLocalizations.of(context)!.productsLoadingFailed} ${effect.failureText}'));
      } else if (effect is ApiKeyNotSaved) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                AppLocalizations.of(context)!.novaPostNoApiKey));
      }
    });
    return BlocBuilder<NovaPostENsCubit, NovaPostENsState>(
      builder: (context, state) {
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
                      cubit.refreshAllENs();
                    },
                    child: Column(
                      children: [
                        InkWell(
                          child: Text(state.savedNovaPostApiKey ?? ''),
                          onTap: () => _displayApiKeyDialog(context),
                        ),
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              backgroundColor: AppTheme.pink,
                              surfaceTintColor: AppTheme.pink,
                              floating: true,
                              pinned: false,
                              snap: true,
                              toolbarHeight: _isSearchVisible ? 56.0 : 0.0,
                              title: _isSearchVisible
                                  ? SearchTextfield(
                                      title:
                                          AppLocalizations.of(context)!.search,
                                      onChanged: (term) =>
                                          cubit.searchProducts(term),
                                    )
                                  : null,
                            ),
                            SliverToBoxAdapter(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  itemCount: state.allENs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = state.allENs[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(14.0),
                                        onTap: () {},
                                        tileColor: AppTheme.white,
                                        title:
                                            Text(item.recipientContactPerson),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(item
                                                    .cityRecipientDescription),
                                                Text(item.recipientPhone),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: SvgPicture.asset(
                                            IconPath.forwardArrow),
                                      ),
                                    );
                                  }),
                            ),
                          ],
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
            title: Text('Enter your Nova Post API key'),
            content: TextField(
              onChanged: (String value) {
                cubit.onApiKeyTextChanged(value);
              },
              controller: cubit.apiKeyController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  cubit.submitNovaPostApiKey(cubit.state.savedNovaPostApiKey);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
