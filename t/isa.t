# $Id: isa.t,v 1.6 2009-11-26 22:11:48 dpchrist Exp $

use Test::More tests => 10;



package Foo;			# base class

use strict;
use warnings;



package Bar;			# derived class

use base qw( Foo );

use strict;
use warnings;



package main;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( :all _isa );
use Test::More;

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $r;

my $bar = bless {}, 'Bar';

$r = eval {
    _isa undef, 'Foo';
};
ok(                                                             #     1
    !defined $r,
    "call on undefined value should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa {}, 'Foo';
};
ok(                                                             #     2
    !defined $r,
    "call on unblessed reference should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa $bar, undef;
};
ok(                                                             #     3
    !defined $r,
    "call on object against the undefined value should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa $bar, {};
};
ok(                                                             #     4
    !defined $r,
    "call on object against unblessed reference should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa $bar, 'Baz';
};
ok(                                                             #     5
    !defined $r,
    "call on object against unrelated class should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa $bar, 'Foo';
};
ok(                                                             #     6
    $r == 1,
    "call on object against related class should " .
    "return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa 'Bar', undef;
};
ok(                                                             #     7
    !defined $r,
    "call on class against the undefined value should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa 'Bar', $bar;
};
ok(                                                             #     8
    !defined $r,
    "call on class against object should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa 'Bar', 'Baz';
};
ok(                                                             #     9
    !defined $r,
    "call on class against unrelated class should " .
    "return the undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    _isa 'Bar', 'Foo';
};
ok(                                                             #    10
    defined $r
    && $r == 1,
    "call on class against related class should " .
    "return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

