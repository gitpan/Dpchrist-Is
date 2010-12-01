# $Id: is_arrayref.t,v 1.1 2010-11-24 16:57:43 dpchrist Exp $

use Test::More tests => 8;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( is_arrayref );

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $r;

$r = eval {	# sneak around prototype compile check
    my $rc = \&is_arrayref;
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
    is_arrayref undef;
};
ok(                                                             #     2
    !$@
    && !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref '';
};
ok(                                                             #     3
    !$@
    && !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref 'foo';
};
ok(                                                             #     4
    !$@
    && !defined $r,
    'call on non-empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref 0;
};
ok(                                                             #     5
    !$@
    && !defined $r,
    'call on zero should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref 1;
};
ok(                                                             #     6
    !$@
    && !defined $r,
    'call on one should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref [];
};
ok(                                                             #     7
    !$@
    && defined $r
    && $r,
    'call on array reference should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_arrayref {};
};
ok(                                                             #     8
    !$@
    && !defined $r,
    'call on hash reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

