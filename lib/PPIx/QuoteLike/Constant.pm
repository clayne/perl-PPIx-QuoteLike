package PPIx::QuoteLike::Constant;

use 5.006;

use strict;
use warnings;

use Carp;
use base qw{ Exporter };

our $VERSION = '0.000_009';

our @EXPORT_OK = qw{
    VARIABLE_RE
};

use constant VARIABLE_RE => qr<
	[[:alpha:]_]\w* (?: :: [[:alpha:]_] \w* )* |
	[[:punct:]]
    >smx;

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

=head2 VARIABLE_RE

This constant is a regular expression object that matches Perl variable
names, without the leading sigil. Nothing is captured.

=head1 SUPPORT

Support is by the author. Please file bug reports at
L<http://rt.cpan.org>, or in electronic mail to the author.

=head1 AUTHOR

Thomas R. Wyant, III F<wyant at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Thomas R. Wyant, III

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.10.0. For more details, see the full text
of the licenses in the directory LICENSES.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=cut

# ex: set textwidth=72 :