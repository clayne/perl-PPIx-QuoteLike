package PPIx::QuoteLike::Token::Interpolation;

use 5.006;

use strict;
use warnings;

use Carp;
use PPI::Document;
use PPIx::QuoteLike::Constant qw{
    LOCATION_COLUMN
    LOCATION_LOGICAL_LINE
    LOCATION_LOGICAL_FILE
    VARIABLE_RE
    @CARP_NOT
};
use PPIx::QuoteLike::Utils qw{ __variables };

use base qw{ PPIx::QuoteLike::Token };

our $VERSION = '0.008_001';

# TODO filch code from PPIx::Regexp::Token::Code.
sub ppi {
    my ( $self ) = @_;
    unless ( $self->{ppi} ) {
	my $content;
	if ( my $location = $self->{location} ) {
	    my $fn;
	    if( defined( $fn = $location->[LOCATION_LOGICAL_FILE] ) ) {
		$fn =~ s/ (?= [\\"] ) /\\/smxg;
		$content = qq{#line $location->[LOCATION_LOGICAL_LINE] "$fn"\n};
	    } else {
		$content = qq{#line $location->[LOCATION_LOGICAL_LINE]\n};
	    }
	    $content .= ' ' x ( $location->[LOCATION_COLUMN] - 1 );
	}
##	The following code is tempting, but I really, really want to
##	avoid enabling it, because I may hit uses of ${something} that
##	it does not cover.
##	( $content = $self->content() ) =~
##	    s/ \A ( [\$\@] (?: \# \$? | \$* ) )
##	    \{ ( @{[ VARIABLE_RE ]} ) \} \z /$1$2/smxo;
	$content .= $self->content();
	$self->{ppi} = PPI::Document->new( \$content, readonly => 1 );
    }
    return $self->{ppi};
}

# For the moment this is package-private and subject to change or
# retraction without notice. If there is need, it will be made public
# by stripping the leading underscores and documenting it.
sub __purge_ppi {
    my ( $self ) = @_;
    return delete $self->{ppi};
}

sub variables {
    my ( $self ) = @_;
    return __variables( $self->ppi() );
}

sub __perl_version_introduced {
    my ( $self ) = @_;
    $self->content() =~ m/ -> (?: \@ [[{*] | % [*] ) /smx
	and return '5.019005';
    return;
}

1;

__END__

=head1 NAME

PPIx::QuoteLike::Token::Interpolation - Represent an interpolation

=head1 SYNOPSIS

This class should not be instantiated by the user. See below for public
methods.

=head1 INHERITANCE

C<PPIx::QuoteLike::Token::Interpolation> is a
L<PPIx::QuoteLike::Token|PPIx::QuoteLike::Token>.

C<PPIx::QuoteLike::Token::Interpolation> has no descendants.

=head1 DESCRIPTION

This Perl class represents an interpolation into a quote-like string.

=head1 METHODS

This class supports the following public methods in addition to those of
its superclass:

=head2 ppi

 my $ppi = $elem->ppi();

This convenience method returns the L<PPI::Document|PPI::Document>
representing the content. This document should be considered read only.
An exception will be thrown if L<PPI::Document|PPI::Document> can not be
loaded.

Note that the content of the returned L<PPI::Document|PPI::Document> may
not be the same as the content of the original
C<PPIx::Regexp::Token::Interpolation>. This can happen because
interpolated variable names may be enclosed in curly brackets, but this
does not happen in normal code. For example, in C</${foo}bar/>, the
content of the C<PPIx::Regexp::Token::Interpolation> object will be
C<'${foo}'>, but the content of the C<PPI::Document> will be C<'$foo'>.

=head2 variables

 say "Interpolates $_" for $elem->variables();

This convenience method returns all interpolated variables. Each is
returned only once, and they are returned in no particular order.

=head1 SEE ALSO

L<PPIx::QuoteLike::Token|PPIx::QuoteLike::Token>.

=head1 SUPPORT

Support is by the author. Please file bug reports at
L<https://rt.cpan.org>, or in electronic mail to the author.

=head1 AUTHOR

Thomas R. Wyant, III F<wyant at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2020 by Thomas R. Wyant, III

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.10.0. For more details, see the full text
of the licenses in the directory LICENSES.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=cut

# ex: set textwidth=72 :
