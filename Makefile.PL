
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Git Changesets, tools for managing you git changes",
  "AUTHOR" => "Grant Street Group",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "App-Gitc",
  "EXE_FILES" => [
    "bin/gitc-edit",
    "bin/gitc-rebase",
    "bin/gitc-quickfix",
    "bin/gitc-history",
    "bin/gitc-branch-point",
    "bin/gitc-list",
    "bin/gitc-fail",
    "bin/git-merge-theirs",
    "bin/gitc-sync",
    "bin/gitc-pass",
    "bin/gitc-log",
    "bin/gitc-promote",
    "bin/gitc-import-tags",
    "bin/gitc",
    "bin/gitc-group",
    "bin/gitc-changesets-in",
    "bin/gitc-current-branch",
    "bin/gitc-diff-versions",
    "bin/gitc-diff",
    "bin/gitc-setup",
    "bin/gitc-touch",
    "bin/gitc-show",
    "bin/gitc-branch",
    "bin/gitc-archive-tags",
    "bin/gitc-add-user",
    "bin/gitc-status",
    "bin/gitc-project-name",
    "bin/gitc-diffsites",
    "bin/gitc-cancel",
    "bin/gitc-unpromoted",
    "bin/gitc-submit",
    "bin/gitc-promoted",
    "bin/gitc-open",
    "bin/gitc-review"
  ],
  "LICENSE" => "open_source",
  "NAME" => "App::Gitc",
  "PREREQ_PM" => {
    "Algorithm::Dependency::Ordered" => 0,
    "Algorithm::Dependency::Source::HoA" => 0,
    "App::Gitc::Config" => 0,
    "App::Gitc::ListFormat::Base" => 0,
    "Carp" => 0,
    "Class::MOP" => 0,
    "Cwd" => 0,
    "Date::Format" => 0,
    "Date::Parse" => 0,
    "Date::PeriodParser" => 0,
    "Email::Simple" => 0,
    "Exporter" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "GSG::Eventum" => 0,
    "Getopt::Long" => 0,
    "Hash::Merge::Simple" => 0,
    "JIRA::Client" => 0,
    "JIRA::Client::REST" => 0,
    "List::MoreUtils" => 0,
    "List::Util" => 0,
    "POSIX" => 0,
    "Pithub::Issues" => 0,
    "Term::ReadLine" => 0,
    "Test::More" => 0,
    "Text::Levenshtein" => 0,
    "Time::Local" => 0,
    "Try::Tiny" => 0,
    "YAML" => 0,
    "YAML::Syck" => 0,
    "base" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {},
  "VERSION" => "0.58",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



