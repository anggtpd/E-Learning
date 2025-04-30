import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/base/constants/ui/app_text_styles.dart';
import 'package:flutter_bloc_template/base/constants/ui/dimens.dart';
import 'package:flutter_bloc_template/base/shared_view/common_app_bar.dart';
import 'package:flutter_bloc_template/base/shared_view/common_button.dart';
import 'package:flutter_bloc_template/base/shared_view/common_check_box.dart';
import 'package:flutter_bloc_template/base/shared_view/common_scaffold.dart';
import 'package:flutter_bloc_template/base/shared_view/common_text_field.dart';
import 'package:flutter_bloc_template/navigation/router.gr.dart';
import 'package:flutter_bloc_template/ui/widgets/social_auth_provider/social_auth_provider_page.dart';
import 'package:gap/gap.dart';

import '../../resource/generated/assets.gen.dart';
import '../../resource/generated/l10n.dart';
import '../widgets/auth_prompt_widget.dart';
import '../widgets/via_widget.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(),
      bottomNavigationBar: AuthPromptWidget(
        message: S.current.already_have_an_account,
        actionText: S.current.sign_in,
        onActionTap: () {
          AutoRouter.of(context).push(const LoginRoute());
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingHorizontalLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(60),
            Text(S.current.create_ur_account, style: AppTextStyles.h1Bold.copyWith(height: 57.6 / 48)),
            const Gap(60),
            CommonTextField(
              hintText: S.current.email,
              prefixIconPath: Assets.icons.message.path,
              onChanged: (val) {},
            ),
            const Gap(20),
            CommonTextField(
              obscureText: true,
              hintText: S.current.password,
              prefixIconPath: Assets.icons.lock.path,
              onChanged: (val) {},
            ),
            const Gap(20),
            Center(
              child: CommonCheckbox(
                label: S.current.remember_me,
                value: false,
                onChanged: (val) {},
              ),
            ),
            const Gap(20),
            CommonButton(
              enable: false,
              onPressed: () {},
              title: S.current.sign_up,
              fullWidth: true,
            ),
            const Gap(Dimens.paddingVerticalLarge),
            ViaWidget(title: S.current.or_continue_with.toLowerCase()),
            const Gap(Dimens.paddingVerticalLarge),
            const SocialAuthProviderPage(hideLabel: true),
          ],
        ),
      ),
    );
  }
}
