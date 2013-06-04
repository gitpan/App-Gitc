package App::Gitc::Its::RT;
{
  $App::Gitc::Its::RT::VERSION = '0.58';
}

use strict;
use warnings;

use App::Gitc::Util qw( project_config );


sub label_service { 'RT' }
sub label_issue { 'RT' }

sub issue_number { shift->{ changeset } }


sub its_for_changeset {
    my ( $class, $changeset ) = @_;

    my $project_config = project_config();

    # Removes non-digits.
    $changeset =~ tr/0-9//cd;

    my $self = {
        rt_url      => $project_config->{ rt_url },
        rt_user     => $project_config->{ rt_user },
        rt_password => $project_config->{ rt_password },
        changeset   => $changeset,
    };

    bless $self, $class;

    return $self;
}


sub run_rt {
    my ( $self, @params ) = @_;

    open my $fh, '-|', '/usr/bin/rt', @params;

    chomp( my @output = <$fh> );

    close $fh;

    if ( $? >> 8 ) {
        die "/usr/bin/rt " . join( q{ }, @params ) . " failed.\n";
    }

    return join qq{\n}, @output;
}


sub transition_state {
    my ( $self, $params ) = @_;

    my $command = $params->{ command };

    my $config = project_config();

    my $command_config = $config->{ rt_statuses }->{ $command };

    if ( $params->{ command } eq 'promote' ) {
        $command_config = $command_config->{ $params->{ target } };
    }

    die "Invalid command for RT: $command.\n" if !$command_config;

    my $qr = qr/$command_config->{ from }/;

    my $current_status = $self->issue_state();

    if ( $current_status !~ $qr ) {
        warn "Ticket is currently in status $current_status. Not changing.\n";
    }

    $self->run_rt(
        'comment', $self->{ changeset },
        '-m', $params->{ message }
    );

    $self->run_rt(
        qw( edit -t ticket ), $self->{ changeset },
        'set', "status=$command_config->{ to }",
    );
}


sub issue_state {
    my ( $self ) = @_;

    my $info = $self->run_rt(
        qw( show -t ticket -s ), $self->{ changeset }
    );

    my ( $current_status ) = $info =~ m{^Status:\s+(.+)\s*$}im;

    return $current_status;    
}


sub get_issue {
    my ( $self ) = @_;

    return $self;
}


sub issue_changeset_uri {
    my ( $self ) = @_;

    my $config = project_config();
    my $uri    = $config->{ rt_url };

    return "$uri/Ticket/Display.html?id=$self->{ changeset }\n";
}


1;

__END__

=pod

=head1 NAME

App::Gitc::Its::RT

=head1 VERSION

version 0.58

=head1 NAME

App::Gitc::Its::RT;

=head1 Synopsis

Support for RT ITS (Issue Tracking System)

=head1 Description

=head1 Methods

=head2 label_*

Just the name of this ITS.

=head2 its_for_changeset

Basically a convoluted 'new'.

=head2 run_rt

Runs RT with the necessary commands, dies if something went wrong.

=head2 transition_state

Method that is called in ::Util to transition a ticket from one status to
another.

=head2 issue_state

Returns the current state of the issue.

=head2 get_issue

Returns an issue from the system.  Because this system initialises ealier, we
just return ourself.

=head2 issue_changeset_uri

Returns an issue's URI.

=head1 AUTHOR

Grant Street Group <F<developers@grantstreet.com>>

=head1 COPYRIGHT AND LICENSE

    Copyright 2013 Grant Street Group, All Rights Reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

=head1 AUTHOR

Grant Street Group

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Grant Street Group.

This is free software, licensed under:

  The GNU Affero General Public License, Version 3, November 2007

=cut
