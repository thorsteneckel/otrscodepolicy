# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package TidyAll::Plugin::OTRS::Whitespace::Tabs;

use strict;
use warnings;

use parent qw(TidyAll::Plugin::OTRS::Base);

use XML::Parser;

sub validate_source {    ## no critic
    my ( $Self, $Code ) = @_;

    return if $Self->IsPluginDisabled( Code => $Code );

    my $Counter = 1;
    my $ErrorMessage;

    #
    # Check for stray tabs
    #
    LINE:
    for my $Line ( split( /\n/, $Code ) ) {

        $Counter++;

        if ( $Line =~ m/\t/ ) {
            $ErrorMessage .= "Line $Counter: $Line\n";
        }

    }

    if ($ErrorMessage) {
        die __PACKAGE__ . "\n" . <<EOF;
Please substitute all tabulators with four spaces.
$ErrorMessage
EOF
    }
}

1;
