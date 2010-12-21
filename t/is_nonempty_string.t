# $Id: is_nonempty_string.t,v 1.3 2010-12-20 06:05:18 dpchrist Exp $

use Test::More tests => 9;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is		qw( is_nonempty_string );


$|				= 1;
$Data::Dumper::Sortkeys		= 1;

my $r;

$r = eval {	# sneak around prototype compile check
    my $rc = \&is_nonempty_string;
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
    is_nonempty_string undef;
};
ok(                                                             #     2
    !$@
    && !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string '';
};
ok(                                                             #     3
    !$@
    && !defined $r,
    'call on empty string should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string [];
};
ok(                                                             #     4
    !$@
    && !defined $r,
    'call on empty array reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string {};
};
ok(                                                             #     5
    !$@
    && !defined $r,
    'call on empty hash reference should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string qr//;
};
ok(                                                             #     6
    !$@
    && !defined $r,
    'call on empty regular expression reference ' .
    'should return the undefined value'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string 0;
};
ok(                                                             #     7
    !$@
    && defined $r
    && $r,
    'call on zero should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string 1;
};
ok(                                                             #     8
    !$@
    && defined $r
    && $r,
    'call on one should return true'
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_nonempty_string 'foo';
};
ok(                                                             #     9
    !$@
    && defined $r
    && $r,
    "call on non-empty string should return true"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

