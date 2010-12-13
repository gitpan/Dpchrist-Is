# $Id: is_coderef.t,v 1.2 2010-12-08 06:41:02 dpchrist Exp $

use Dpchrist::Is		qw( is_coderef );

use Test::More tests		=> 10;

use strict;
use warnings;

use Carp;
use Data::Dumper;

local $|			= 1;
$Data::Dumper::Sortkeys		= 1;


my $r;

$r = eval {	# sneak around prototype compile check
    my $rc = \&is_coderef;
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
    is_coderef undef;
};
ok(                                                             #     2
    !$@
    && !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef '';
};
ok(                                                             #     3
    !$@
    && !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef 'foo';
};
ok(                                                             #     4
    !$@
    && !defined $r,
    'call on non-empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef 0;
};
ok(                                                             #     5
    !$@
    && !defined $r,
    'call on zero should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef 1;
};
ok(                                                             #     6
    !$@
    && !defined $r,
    'call on one should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef [];
};
ok(                                                             #     7
    !$@
    && !defined $r,
    'call on array reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef {};
};
ok(                                                             #     8
    !$@
    && !defined($r),
    'call on hash reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef qr//;
};
ok(                                                             #     9
    !$@
    && !defined($r),
    'call on regexp reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_coderef sub {};
};
ok(                                                             #    10
    !$@
    && $r,
    'call on code reference should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

