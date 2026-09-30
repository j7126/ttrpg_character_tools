import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:render_ttrpg_data/data_views/generic/entry_view/text_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/skill_proficiency/skill_proficiency_mixin.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skills_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';

class CharacterBuildSkillProficency extends StatefulWidget {
  const CharacterBuildSkillProficency({super.key, required this.context});

  final CharacterContext context;

  @override
  State<CharacterBuildSkillProficency> createState() =>
      _CharacterBuildSkillProficencyState();
}

class _CharacterBuildSkillProficencyState
    extends State<CharacterBuildSkillProficency> {
  ExpansibleController controller = ExpansibleController();

  bool get hasValues =>
      widget.context.character.skills.currentProficency.isNotEmpty;

  void _selectionsChanged() {
    if (!mounted) {
      return;
    }

    widget.context.character.skills.applyChoices();

    widget.context.changed();
  }

  @override
  void initState() {
    if (hasValues) {
      controller.collapse();
    } else {
      controller.expand();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var initialClassName =
        widget.context.character.classInfo.firstOrNull?.className;
    var bonusProviders = widget.context.allRulesObjs
        .where(
          (x) =>
              !(x.$1 is Class5e &&
                  initialClassName != null &&
                  x.$1.name != initialClassName),
        )
        .map((x) {
          var obj = x.$1;
          return obj is SkillProficiencyMixin &&
                  obj.skillProficiencies != null &&
                  obj.skillProficiencies!.isNotEmpty
              ? obj
              : null;
        })
        .nonNulls
        .toList();

    var profChoices = Map<String, CharacterProficencyChoice>.fromEntries(
      widget.context.character.skills.proficencyChoices.map(
        (x) => MapEntry(x.providerRef, x),
      ),
    );

    var children = <Widget>[];

    for (var provider in bonusProviders) {
      var selection = profChoices[provider.refString];
      if (selection == null) {
        selection = CharacterProficencyChoice(providerRef: provider.refString);
        widget.context.character.skills.proficencyChoices.add(selection);
      }
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextView(
                    provider.refString,
                    hintEntities: [provider],
                    style: TextStyle(
                      fontSize: TextStyles.of(context).headline2?.fontSize,
                    ),
                  ),
                  Gap(8.0),
                  Text(provider.skillProficiencyDisplayString),
                ],
              ),
              if (provider.skillProficiencies!.first.chooseNumber > 0 &&
                  provider.skillProficiencies!.first.chooseSkills.isNotEmpty)
                Wrap(
                  children: () {
                    var children = <Widget>[];
                    for (var skill
                        in provider.skillProficiencies!.first.chooseSkills) {
                      var currentVal = selection!.choices.contains(
                        skill.toCharacterSkill(),
                      );
                      children.add(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: currentVal,
                              onChanged:
                                  currentVal ||
                                      selection.choices.length <
                                          provider
                                              .skillProficiencies!
                                              .first
                                              .chooseNumber
                                  ? (val) {
                                      if (selection == null) {
                                        return;
                                      }
                                      var sk = skill.toCharacterSkill();
                                      if (val == true) {
                                        if (!selection.choices.contains(sk)) {
                                          selection.choices.add(sk);
                                        }
                                      } else {
                                        selection.choices.remove(sk);
                                      }
                                      _selectionsChanged();
                                    }
                                  : null,
                            ),
                            Text(skill.name),
                          ],
                        ),
                      );
                    }
                    return children;
                  }(),
                ),
            ],
          ),
        ),
      );
    }

    if (bonusProviders.isEmpty) {
      return Container();
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        controller: controller,
        onExpansionChanged: (value) {
          setState(() {});
        },
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Skill Proficency", style: TextStyles.of(context).headline1),
              Spacer(),
            ],
          ),
        ),
        enabled: hasValues || !controller.isExpanded,
        dense: true,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: AlignmentGeometry.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        tilePadding: EdgeInsets.symmetric(horizontal: 8),
        children: children,
      ),
    );
  }
}
