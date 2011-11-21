package Test::Meta::Rule;

use strict;
use warnings;

use Module::Want       ();
use Test::Meta::Action ();

our $VERSION = '0.1';

my $built_ins = {
    'RELEASE_TESTING' => {
        'need_action' => sub {

            # my ($desc) = @_;
            return if $ENV{'RELEASE_TESTING'};
            return 1;
        },
        'take_action' => sub {
            my ($desc) = @_;
            Test::Meta::Action::skip_all("$desc tests are only run under RELEASE_TESTING");
        },
    },

    'AUTOMATED_TESTING' => {
        'need_action' => sub {

            # my ($desc) = @_;
            return if !$ENV{'AUTOMATED_TESTING'};
            return 1;
        },
        'take_action' => sub {
            my ($desc) = @_;
            Test::Meta::Action::skip_all("$desc tests are only run under AUTOMATED_TESTING");
        },
    },

    'HEAVY_TESTING' => {
        'need_action' => sub {

            # my ($desc) = @_;
            return if $ENV{'HEAVY_TESTING'};
            return 1;
        },
        'take_action' => sub {
            my ($desc) = @_;
            Test::Meta::Action::skip_all("$desc tests are only run under HEAVY_TESTING");
        },
    },

    'OS' => {
        'need_action' => sub {
            my ($desc) = @_;
            return if ...;
            return 1;
        },
        'take_action' => sub {
            my ($desc) = @_;
            Test::Meta::Action::skip_all("$desc tests are only run under ...");
        },
    },

    # 'Meh' => ... turn failures into TODO
};

sub get_rule {
    my ($rule) = @_;

    return $rule if exists $built_ins->{$rule};

    my $ns = "Test::Meta::Rule::$rule";
    return if !Module::Want::have_mod($ns);    # have_mod() sanitizes $ns so no code injection is possible
    return $ns->get_rule();
}

1;

__END__

=encoding utf8

=head1 NAME

Test::Meta - Explictly describe your tests and automatically act on said description


=head1 VERSION

This document describes Test::Meta version 0.1


=head1 SYNOPSIS

    use Test::Meta (
        'POD' => 1,
        'Memory' => 1
    );

…

    # SKIP POD tests are only run under RELEASE_TESTING.
  

=head1 DESCRIPTION

Using this module a developer can describe (L<Test::Meta::Desc>) his tests.

At runtime the description helps define a set of rules (L<Test::Meta::Rule>) to act on.

For example, in the SYNOPSIS example the POD rule enabled the RELEASE_TESTING Rule.

=head1 INTERFACE 

This is a super basic and inflexible–logic list that highlights the idea.

The value of each given rule is passed to the rule or rules it triggers so it can act accordingly.

=head2 Built in Rules

=over 4

=item RELEASE_TESTING

skip_all(…) if !$ENV{'RELEASE_TESTING'}


=item AUTOMATED_TESTING

skip_all(…) if $ENV{'AUTOMATED_TESTING'}


=item HEAVY_TESTING

skip_all(…) if !$ENV{'HEAVY_TESTING'}

=item OS

skip_all(…) if the current OS is not the same as the given OS

=item Meh

turn fail()s into TODOs

=back 

=head2 Built in Descriptions

=over

=item STDIN

triggers the AUTOMATED_TESTING rule

=item ARGV

triggers the AUTOMATED_TESTING rule

=item IO

triggers the HEAVY_TESTING rule

=item Memory

triggers the HEAVY_TESTING rule

=item Network

triggers the HEAVY_TESTING rule

=item POD

triggers the RELEASE_TESTING rule (or Meh?)

=item Unix, Mac, OS2, Win32, VMS, …

triggers the OS rule

=back


=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
Test::Meta requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-test-meta@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 TODO

=over 4

=item Description hash parsing.

=item Configuration file/ENV

=item Use cases

=back 

=head1 AUTHOR

cPanel, Inc.  C<< <cpan@cpanel.net> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2011, CPanel. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
