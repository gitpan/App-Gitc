package App::Gitc::UserLookup::LocalGroup;
{
  $App::Gitc::UserLookup::LocalGroup::VERSION = '0.58';
}

use strict;
use warnings;

use App::Gitc::Util qw( project_config );

# Users are local users in a specific group.
sub users {
    my $group = project_config()->{ user_lookup_group };

    return split m{,}, ( getgrnam( $group ) )[3]
}

1;

__END__

=pod

=head1 NAME

App::Gitc::UserLookup::LocalGroup

=head1 VERSION

version 0.58

=head1 AUTHOR

Grant Street Group

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Grant Street Group.

This is free software, licensed under:

  The GNU Affero General Public License, Version 3, November 2007

=cut
