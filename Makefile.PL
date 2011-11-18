use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Meta',
    AUTHOR              => 'cPanel, Inc. <cpan@cpanel.net>',
    VERSION_FROM        => 'lib/Test/Meta.pm',
    ABSTRACT_FROM       => 'lib/Test/Meta.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Meta-*' },
);
