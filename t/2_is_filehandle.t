# $Id: 2_is_filehandle.t,v 1.3 2009-11-26 22:11:48 dpchrist Exp $

use Test::More tests => 14;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Dpchrist::Is	qw( :all );

$Data::Dumper::Sortkeys = 1;

$| = 1;

my $f;
my $fh;
my $r;
my $rc = \&is_filehandle;

$r = eval {
    &$rc;
};
ok(                                                             #     1
    !defined $r,
    'call without arguments should return the undefined value'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle undef;
};
ok(                                                             #     2
    !defined $r,
    'call on undefined value should return the undefined value'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle '';
};
ok(                                                             #     3
    !defined $r,
    'call on empty string should return the undefined value'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle 0;
};
ok(                                                             #     4
    !defined $r,
    'call on zero return the undefined value'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle {};
};
ok(                                                             #     5
    !defined $r,
    'call on reference should return the undefined value'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle $f;
};
ok(                                                             #     6
    !defined $r,
    "call on file name should return undefined value"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle *STDIN;
};
ok(                                                             #     7
     defined $r
     && $r == 1,
    'call on *STDIN should return true'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle *STDOUT;
};
ok(                                                             #     8
     defined $r
     && $r == 1,
    'call on *STDOUT should return true'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle *STDERR;
};
ok(                                                             #     9
     defined $r
     && $r == 1,
    'call on *STDERR should return true'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$f = join '~', __FILE__, __LINE__, 'tmp';

open (F, "> $f") or die $!;

$r = eval {
    is_filehandle *F;
};
ok(                                                             #    10
     defined $r
     && $r == 1,
    "call on *F should return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

$r = eval {
    is_filehandle '*F';
};
ok(                                                             #    11
     defined $r
     && $r == 1,
    "call on string '*F' should return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

close F or die $!;

$r = eval {
    is_filehandle *F;
};
ok(                                                             #    12
     defined $r
     && $r == 1,
    "call on closed filehandle should return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

open ($fh, $f) or die $!;

$r = eval {
    is_filehandle $fh;
};
ok(                                                             #    13
     defined $r
     && $r == 1,
    "call on open file handle variable should return true"
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

close $fh or die $!;

$r = eval {
    is_filehandle $fh;
};
ok(                                                             #    14
    defined $r
    && $r == 1,
    'call on closed file handle variable should return true'
) or confess join(" ", __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $@], [qw(r @)]),
);

