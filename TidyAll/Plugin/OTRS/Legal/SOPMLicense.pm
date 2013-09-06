package TidyAll::Plugin::OTRS::Legal::SOPMLicense;

use strict;
use warnings;

use base qw(TidyAll::Plugin::OTRS::Base);

sub validate_source {
    my ( $Self, $Code ) = @_;

    return if $Self->IsPluginDisabled(Code => $Code);

    if ( $Code !~ m{<License> .+? </License>}smx ) {
        die __PACKAGE__ . "\nCould not find a license header."
    }

    if ( $Code !~ m{<License>GNU \s AFFERO \s GENERAL \s PUBLIC \s LICENSE \s Version \s 3, \s November \s 2007</License>}smx ) {
        die __PACKAGE__ . "\n" . <<EOF;
Invalid license found.
Use <License>GNU AFFERO GENERAL PUBLIC LICENSE Version 3, November 2007</License>.
EOF
    }

    return;

}

sub transform_source {
    my ( $Self, $Code ) = @_;

    return $Code if $Self->IsPluginDisabled(Code => $Code);

    # Replace GPL2 with AGPL3
    $Code =~ s{<License>GNU \s GENERAL \s PUBLIC \s LICENSE \s Version \s 2, \s June \s 1991</License>}{<License>GNU AFFERO GENERAL PUBLIC LICENSE Version 3, November 2007</License>}gsmx;

    return $Code;
}

1;