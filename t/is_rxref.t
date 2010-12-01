# $Id: is_rxref.t,v 1.1 2010-11-25 00:51:07 dpchrist Exp $

use Test::More tests => 9;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is		qw( is_rxref );

local $|			= 1;
$Data::Dumper::Sortkeys		= 1;


my $r;

$r = eval {	# sneak around prototype compile check
    my $rc = \&is_rxref;
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
    is_rxref undef;
};
ok(                                                             #     2
    !$@
    && !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref '';
};
ok(                                                             #     3
    !$@
    && !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref 'foo';
};
ok(                                                             #     4
    !$@
    && !defined $r,
    'call on non-empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref 0;
};
ok(                                                             #     5
    !$@
    && !defined $r,
    'call on zero should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref 1;
};
ok(                                                             #     6
    !$@
    && !defined $r,
    'call on one should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref [];
};
ok(                                                             #     7
    !$@
    && !defined $r,
    'call on array reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref {};
};
ok(                                                             #     8
    !$@
    && !defined($r),
    'call on hash reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_rxref qr//;
};
ok(                                                             #     9
    !$@
    && $r,
    'call on reference to regular expression should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

