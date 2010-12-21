# $Id: is_filename.t,v 1.7 2010-12-20 06:05:18 dpchrist Exp $

use strict;
use warnings;

use Test::More tests => 7;

use Dpchrist::Is	qw( is_filename );

use Carp;
use Cwd;
use Data::Dumper;
use File::Basename;

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $cwd = getcwd;
my $f;
my $r;
my $rc = \&is_filename;

$r = eval {
    &$rc;
};
ok(                                                             #     1
    !defined $r,
    'call without arguments should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filename undef;
};
ok(                                                             #     2
    !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filename '';
};
ok(                                                             #     3
    !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filename {};
};
ok(                                                             #     4
    !defined $r,
    'call on reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    $f = __FILE__ . __LINE__;
    is_filename catfile(__FILE__ . '~tmp', __FILE__ . __LINE__);
};
ok(                                                             #     5
    !defined $r,
    'call on file in non-existent directory ' .
    'should return undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@, $cwd, $f], [qw(r @ cwd f)]),
);

$r = eval {
    $f = __FILE__;
    is_filename $f;
};
ok(                                                             #     6
     defined $r
     && $r == 1,
    'call on test script filename should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@, $cwd, $f], [qw(r @ cwd f)]),
);

$r = eval {
    $f = join '~', basename(__FILE__), __LINE__, 'tmp';
    is_filename $f;
};
ok(                                                             #     7
     defined $r
     && $r == 1,
    'call on writeable file name should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@, $cwd, $f], [qw(r @ cwd f)]),
);

