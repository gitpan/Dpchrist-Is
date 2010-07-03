# $Id: 2_is_filename.t,v 1.5 2009-11-26 22:11:48 dpchrist Exp $

use Test::More tests => 7;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( :all );

$Data::Dumper::Sortkeys = 1;

$| = 1;

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
    is_filename 'no/such/file';
};
ok(                                                             #     5
    !defined $r,
    "call on 'no/such/file' should return undefined value"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filename __FILE__;
};
ok(                                                             #     6
     defined $r
     && $r == 1,
    'call on test script filename should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$f = join '~', __FILE__, __LINE__, 'tmp';

$r = eval {
    is_filename $f;
};
ok(                                                             #     7
     defined $r
     && $r == 1,
    "call on '$f' should return true"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

