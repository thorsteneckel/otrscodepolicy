use strict;
use warnings;

package TidyAll::Plugin::OTRS::PerlCritic;
BEGIN {
  $TidyAll::Plugin::OTRS::PerlCritic::VERSION = '0.01';
}
use base qw(TidyAll::Plugin::OTRS::PluginBase);
use Perl::Critic;

our $Critic = Perl::Critic->new( -severity => 5 );

sub validate_file {
    my ( $Self, $Filename ) = @_;

    return if $Self->is_disabled( Filename => $Filename );

    my @Violations = $Critic->critique($Filename);

    if (@Violations) {
        die "@Violations";
    }
}

1;



=pod

=head1 NAME

TidyAll::Plugin::XMLLint - use xmllint with tidyall

=head1 VERSION

version 0.01

=head1 SYNOPSIS

   In configuration:

   [XMLLint]
   select = static/**/*.xml

=head1 DESCRIPTION

Runs xmllint, an XML validator, and dies if any problems are found.

=head1 INSTALLATION

Install xmllint, then install this module via CPAN. xmllint is probably available
from your linux repository: on Red Hat Enterprise Linux or CentOS it is packaged
in the libxml2 package. On Windows it is installed when you install
L<Strawberry Perl|http://strawberryperl.com/>.

=head1 CONFIGURATION

=over

=item argv

Arguments to pass to xmllint

=item cmd

Full path to xmllint

=back

=head1 SEE ALSO

L<Code::TidyAll|Code::TidyAll>

=head1 AUTHOR

Michiel Beijen <michiel.beijen@otrs.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Michiel Beijen

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__