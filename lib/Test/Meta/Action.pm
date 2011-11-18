package Test::Meta::Action;

# cpanel - ModPath.pm                             Copyright(c) 2011 cPanel, Inc.
#                                                           All rights Reserved.
# copyright@cpanel.net                                         http://cpanel.net
# This code is subject to the cPanel license. Unauthorized copying is prohibited

use Test::More;
use warnings;
use strict;

sub new {
    my ($class, %obj) = @_;
    $obj{'action'} ||= [ 'pass' ];
    foreach my $attr ( qw/action condition envvar/ ) {
        $obj{$attr} ||= [];
        $obj{$attr} = [ $obj{$attr} ] if defined $obj{$attr} && !ref $obj{$attr};
        die "The value of '$attr' must be an array ref.\n" unless ref([]) eq ref($obj{'$attr'});
    }
    return bless \%obj, $class;
}

sub is_triggered {
    my ($self, $metadata) = @_;

    my %meta = map { $_ => 1 } @$metadata;
    # Test if the metadata matches my description
    #    Return false if not
    if ( grep { $meta{$_} } @{$self->{'condition'}} ) {
        return if grep { $ENV{$_} } @{$self->{'envvar'}};

        return 1;
    }

    return;
}

sub apply {
    my ($self) = @_;
    my ($action, $msg) = @{$obj->{'action'}};
    return 1 if $action eq 'pass';

    if ( $action eq 'pass' ) {
        return 1;
    }
    elsif ( $action eq 'skip' ) {
        plan skip_all => ($msg || 'All tests skipped' );
    }
    elsif ( $action eq 'todo' ) {
    }
    elsif ( $action eq 'die' ) {
        die ($msg || 'Fail the whole test file');
    }
    elsif ( $action eq 'bail' ) {
        BAIL_OUT( $msg||'Fail the whole test suite' );
    }
    elsif ( $action eq 'meh' ) {
        # Sort of like todo
    }
    return;
}

1;

