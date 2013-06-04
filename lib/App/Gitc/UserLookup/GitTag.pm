package App::Gitc::UserLookup;
{
  $App::Gitc::UserLookup::VERSION = '0.58';
}

use strict;
use warnings;

use App::Gitc::Util qw( git );

# Lets you put your users in a git tag.
sub users {
    return map { s{^user/}{}; $_ } git 'tag -l user/*';    
}

__END__

=pod

=head1 NAME

App::Gitc::UserLookup

=head1 VERSION

version 0.58

=head1 AUTHOR

Grant Street Group

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Grant Street Group.

This is free software, licensed under:

  The GNU Affero General Public License, Version 3, November 2007

=cut
