import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:core/src/app/data/impl/question_option.dart';
import 'package:flutter/material.dart';
import 'package:local_hero/local_hero.dart';

class QuestionWithOptionsWidget extends StatefulWidget {
  final List<QuestionOption> options;
  final PickedOption onPickOption;
  final bool isLocalHeroEnable;

  const QuestionWithOptionsWidget({
    super.key,
    required this.options,
    required this.onPickOption,
    required this.isLocalHeroEnable,
  });

  @override
  State<QuestionWithOptionsWidget> createState() => _QuestionWithOptionsWidgetState();
}

class _QuestionWithOptionsWidgetState extends State<QuestionWithOptionsWidget> {
  int pickedOption = -1;
  @override
  Widget build(BuildContext context) {
    List<String> options = widget.options.map((element) => element.text ?? "").toList();
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              QuestionOptionItem(
                  backgroundColor: Colors.green,
                  index: 0,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.green);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
              QuestionOptionItem(
                  backgroundColor: Colors.blue,
                  index: 1,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.blue);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              QuestionOptionItem(
                  backgroundColor: Colors.yellow,
                  index: 2,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.yellow);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
              QuestionOptionItem(
                  backgroundColor: Colors.red,
                  index: 3,
                  texts: options,
                  onItemClick: (i) {
                    setState(() => pickedOption = i);
                    widget.onPickOption.call(i, Colors.red);
                  },
                  isLocalHeroEnable: widget.isLocalHeroEnable,
                  pickedOption: pickedOption),
            ],
          ),
        ),
      ],
    );
  }
}

typedef IntCallback = void Function(int index);

class QuestionOptionItem extends StatelessWidget {
  final Color backgroundColor;
  final List<String> texts;
  final IntCallback onItemClick;
  final int index;
  final bool isPicked;
  final bool hasAnyPickedOption;
  final bool isLocalHeroEnable;

  const QuestionOptionItem(
      {super.key,
      required this.backgroundColor,
      required this.texts,
      required this.onItemClick,
      required this.index,
      required int pickedOption,
      required this.isLocalHeroEnable})
      : isPicked = (pickedOption == index),
        hasAnyPickedOption = (pickedOption != -1);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: WidgetWrapper(
          wrapper: (child) => isLocalHeroEnable && isPicked ? LocalHero(tag: "pickedItem", child: child) : child,
          child: GestureDetector(
            onTap: () => onItemClick.call(index),
            child: AnimatedOpacity(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              opacity: (hasAnyPickedOption && !isPicked) ? 0 : 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backgroundColor.withAlpha(isPicked ? 150 : 125),
                child: Center(
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    texts[index],
                    minFontSize: 12,
                    style: const TextStyle(fontSize: 22, color: Colors.white, height: 0.95),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

typedef PickedOption = void Function(int index, Color color);
