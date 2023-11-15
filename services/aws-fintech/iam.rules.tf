
resource "aws_config_config_rule" "AccessKeysRotated1" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "AccessKeysRotated"
  description = "Checks whether the active access keys are rotated within the number of days specified in maxAccess KeyAge. The rule is non-compliant if the access keys have not been rotated for more than maxAccessKeyAge number of days."

  source {
    owner            = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }

  input_parameters = jsonencode({
    maxAccessKeyAge = "90"
  })
}

resource "aws_config_config_rule" "IAMGroupHasUsersCheck" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMGroupHasUsersCheck"
  description = "Checks whether IAM groups have at least one IAM user."

  source {
    owner            = "AWS"
    source_identifier = "IAM_GROUP_HAS_USERS_CHECK"
  }
}

resource "aws_config_config_rule" "IAMPasswordPolicy" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMPasswordPolicy"
  description = "Checks whether the account password policy for IAM users meets the specified requirements."

  source {
    owner            = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
}

resource "aws_config_config_rule" "IAMPolicyNoStatementsWithAdminAccess" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMPolicyNoStatementsWithAdminAccess"
  description = "Checks whether the default version of AWS Identity and Access Management (IAM) policies do not have administrator access. If any statement has Effect Allow with Action: * over Resource: *, the rule is non-compliant."

  source {
    owner            = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }
}

resource "aws_config_config_rule" "IAMRootAccessKeyCheck" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMRootAccessKeyCheck"
  description = "Checks whether the root user access key is available. The rule is compliant if the user access key does not exist."

  source {
    owner            = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }
}

resource "aws_config_config_rule" "IAMUserGroupMembershipCheck" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMUserGroupMembershipCheck"
  description = "Checks whether IAM users are members of at least one IAM group."

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }
}

resource "aws_config_config_rule" "IAMUserMFAEnabled" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMUserMFAEnabled"
  description = "Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled."

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "IAMUserNoPoliciesCheck" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMUserNoPoliciesCheck"
  description = "Checks that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
}

resource "aws_config_config_rule" "IAMUserUnusedCredentialsCheck" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "IAMUserUnusedCredentialsCheck"
  description = "Checks whether your AWS Identity and Access Management (IAM) users have passwords or active access keys that have not been used within the specified number of days you provided."

  input_parameters = jsonencode({
    maxCredentialUsageAge = "90"
  })

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }
}

resource "aws_config_config_rule" "MFAEnabledForIAMConsoleAccess" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "MFAEnabledForIAMConsoleAccess"
  description = "Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password. The rule is compliant if MFA is enabled."

  source {
    owner            = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
}

resource "aws_config_config_rule" "RootAccountHardwareMFAEnabled" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "RootAccountHardwareMFAEnabled"
  description = "Checks whether your AWS account is enabled to use multi-factor authentication (MFA) hardware device to sign in with root credentials."

  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_HARDWARE_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "RootAccountMFAEnabled" {
  count = strcontains(var.aws_configrules,"iam")? 1:0
  name = "RootAccountMFAEnabled"
  description = "Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."

  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
}
