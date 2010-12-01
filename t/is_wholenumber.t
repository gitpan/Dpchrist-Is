# $Id: is_wholenumber.t,v 1.3 2009-11-26 22:11:48 dpchrist Exp $

use Test::More tests => 10;


use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( :all );

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $f;
my $r;
my $rc = \&is_wholenumber;

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
    is_wholenumber undef;
};
ok(                                                             #     2
    !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber '';
};
ok(                                                             #     3
    !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber 'foo';
};
ok(                                                             #     4
    !defined $r,
    "call on non-numeric string should return the undefined value"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber {};
};
ok(                                                             #     5
    !defined $r,
    'call on reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber -1;
};
ok(                                                             #     6
     !defined $r,
    'call on negative integer should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber 3.141592654;
};
ok(                                                             #     7
    !defined $r,
    'call on floating point number should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber 0;
};
ok(                                                             #     8
    defined $r
    && $r == 1,
    'call on zero should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber 1;
};
ok(                                                             #     9
    defined $r
    && $r == 1,
    'call on one should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_wholenumber 10;
};
ok(                                                             #    10
    defined $r
    && $r == 1,
    'call on ten should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

