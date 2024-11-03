part of '../reader.dart';

class _SearchScaffold extends StatelessWidget {
  const _SearchScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: const _SearchResultList(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SearchRangeSelector(),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 0.0, 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _SearchField(),
                    ),
                    _SearchSubmitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
