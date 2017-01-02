package PPIx::QuoteLike::Constant;

use 5.006;

use strict;
use warnings;

use Carp;
use base qw{ Exporter };

our $VERSION = '0.005';

our @EXPORT_OK = qw{
    MINIMUM_PERL
    VARIABLE_RE
};

use constant MINIMUM_PERL	=> '5.000';

# Match the name of a variable. The user of this needs to anchor it
# right after the sigil. The line noise is [[:punct:]] as documented in
# perlrecharclass, less anything that needs to be excluded (currently
# only '@' and '*').
use constant VARIABLE_RE => qr/
	[[:alpha:]_]\w* (?: :: [[:alpha:]_] \w* )* |
	\^ [A-Z_] |
	[0-9]+ |
	[-!"#\$%&'()+,.\/:;<=>?[\\\]^_`{|}~]
    /smx;

1;

__END__

=head1 NAME

PPIx::QuoteLike::Constant - Constants needed by PPIx-QuoteLike

=head1 SYNOPSIS

This package is private to the C<PPIx-QuoteLike> distribution.

=head1 DESCRIPTION

This module is private to the C<PPIx-QuoteLike> package.  Documentation
is for the benefit of the author, who reserves the right to change or
revoke anything here, including the entire module, without notice.

This module provides importable manifest constants used by multiple
modules in the C<PPIx-QuoteLike> package. Nothing is exported by
default.

=head1 CONSTANTS

The following importable constants are provided:

=head2 MINIMUM_PERL

The minimum version of Perl understood by this parser, as a string. It
is currently set to C<'5.000'>, since that is the minimum version of
Perl accessible to the author.

=head2 VARIABLE_RE

This constant is a regular expression object that matches Perl variable
names, without the leading sigil. Nothing is captured.

=head1 SUPPORT

Support is by the author. Please file bug reports at
L<http://rt.cpan.org>, or in electronic mail to the author.

=head1 AUTHOR

Thomas R. Wyant, III F<wyant at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017 by Thomas R. Wyant, III

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.10.0. For more details, see the full text
of the licenses in the directory LICENSES.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=cut

# ex: set textwidth=72 :
