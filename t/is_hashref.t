# $Id: is_hashref.t,v 1.3 2010-12-20 06:05:18 dpchrist Exp $

use Test::More tests => 8;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( is_hashref );

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $r;

$r = eval {	# sneak around prototype compile check
    my $rc = \&is_hashref;
    &$rc;
};
ok(                                                             #     1
    !$@
    && !defined $r,
    'call without arguments should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref undef;
};
ok(                                                             #     2
    !$@
    && !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref '';
};
ok(                                                             #     3
    !$@
    && !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref 'foo';
};
ok(                                                             #     4
    !$@
    && !defined $r,
    'call on non-empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref 0;
};
ok(                                                             #     5
    !$@
    && !defined $r,
    'call on zero should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref 1;
};
ok(                                                             #     6
    !$@
    && !defined $r,
    'call on one should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref {};
};
ok(                                                             #     7
    !$@
    && defined $r
    && $r,
    'call on hash reference should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_hashref [];
};
ok(                                                             #     8
    !$@
    && !defined $r,
    'call on hash reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

