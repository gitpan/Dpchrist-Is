#######################################################################
# $Id: Is.pm,v 1.17 2010-02-27 21:10:47 dpchrist Exp $
#######################################################################
# package:
#----------------------------------------------------------------------

package Dpchrist::Is;

use 5.010000;
use strict;
use warnings;

require Exporter;

our @ISA	= qw( Exporter );

our %EXPORT_TAGS = ( 'all' => [ qw(
    is_filehandle
    is_filename
    is_wholenumber
    isa_class
    isa_object
) ], );

our @EXPORT_OK = (
    @{ $EXPORT_TAGS{'all'} },
    qw( _isa ),
);

our @EXPORT	= qw();

our $VERSION	= sprintf "%d.%03d", q$Revision: 1.17 $ =~ /(\d+)/g;

#######################################################################
# uses:
#----------------------------------------------------------------------

use Scalar::Util	qw( blessed looks_like_number );

#######################################################################

=head1 NAME

Dpchrist::Is - various type tests


=head1 DESCRIPTION

=head2 SUBROUTINES

=cut

#######################################################################

=head3 is_filehandle($)

    is_filehandle EXPR

Returns true (1) if EXPR is a file handle.
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub is_filehandle($)
{
    my ($fh) = @_;

    my $r = eval {
	defined $fh
	&& ( ref($fh) eq 'GLOB'
	    || !ref($fh) && $fh =~ /^\*\w+(\:\:\w+)*$/
	)
	? 1
	: undef
    };

    ### ignore $@

    return $r;
}

#######################################################################

=head3 is_filename($)

    is_filename EXPR

Returns true (1) if EXPR is the name of an existing file
or if Perl can open a file for writing on that name
(opens, closes, and unlinks file to find out).
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub is_filename($)
{
    my ($f) = @_;

    my $r;
    
    if (defined $f && !ref $f) {
	if (-e $f) {
	    $r = 1;
	}
	else {
	    eval {
		open(F, "> $f") or die $!;
		close F         or die $!;
		unlink $f       or die $!;
	    };
	    $r = 1 unless $@;
	}
    }

    return $r;
}

#######################################################################

=head3 is_wholenumber($)

    is_wholenumber EXPR

Returns true (1) if EXPR is a whole number.
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub is_wholenumber($)
{
    my ($n) = @_;

    my $r = eval {
	defined $n
	&& !ref($n)
    	&& looks_like_number $n
	&& 0 <= $n
	&& int($n) == $n
	? 1
	: undef
    };

    ### ignore $@

    return $r;
}

#######################################################################

=head3 isa_class

    isa_class EXPR1,EXPR2

Returns true (1) if EXPR1 is a class of type EXPR2,
or derived from EXPR2.
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub isa_class($$)
{
    my ($x, $c) = @_;

    my $r = eval {
	defined $x
	&& !ref($x)
	&& defined $c
	&& !ref($c)
	&& $x->isa($c)
	? 1
	: undef
    };

    ### ignore $@

    return $r;
}

#######################################################################

=head3 isa_object

    isa_object EXPR1,EXPR2

Returns true (1) if EXPR1 is an object of type EXPR2,
or derived from EXPR2.
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub isa_object($$)
{
    my ($x, $c) = @_;

    my $r = eval {
	defined $x
	&& ref($x)
	&& blessed($x)
	&& defined $c
	&& !ref($c)
	&& $x->isa($c)
	? 1
	: undef
    };

    ### ignore $@

    return $r;
}

#######################################################################

=head3 _isa

    _isa EXPR1,EXPR2

Returns true (1) if EXPR1 is an object or class of type EXPR2,
or derived from EXPR2.
Otherwise, returns the undefined value.

This subroutine should not generate exceptions.

=cut

#----------------------------------------------------------------------

sub _isa($$)
{
    my ($x, $c) = @_;

    my $r = eval {
	defined $x
	&& (!ref($x) || blessed($x))
	&& defined $c
	&& !ref($c)
	&& $x->isa($c)
	? 1
	: undef
    };

    ### ignore $@

    return $r;
}

#######################################################################
# end of code:
#----------------------------------------------------------------------

1;

__END__

#######################################################################

=head1 INSTALLATION

    perl Makefile.PL
    make
    make test
    make install


=head1 DEPENDENCIES

    Dpchrist::Module


=head1 SEE ALSO

    Scalar::Util


=head1 AUTHOR

David Paul Christensen dpchrist@holgerdanske.com


=head1 COPYRIGHT AND LICENSE

Copyright 2010 by David Paul Christensen dpchrist@holgerdanske.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
USA.

=cut

#######################################################################
