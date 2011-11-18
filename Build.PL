use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::Meta',
    license             => 'perl',
    dist_author         => 'cPanel, Inc. <cpan@cpanel.net>',
    dist_version_from   => 'lib/Test/Meta.pm',
    requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Test-Meta-*' ],
);

$builder->create_build_script();
