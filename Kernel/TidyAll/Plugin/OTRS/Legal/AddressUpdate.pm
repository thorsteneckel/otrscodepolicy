# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package TidyAll::Plugin::OTRS::Legal::AddressUpdate;

use strict;
use warnings;

use parent qw(TidyAll::Plugin::OTRS::Base);

sub transform_source {    ## no critic
    my ( $Self, $Code ) = @_;

    return $Code if $Self->IsPluginDisabled( Code => $Code );

    $Code =~ s{Norsk-Data-Str\.\s+1}{Zimmersmühlenweg 11}smxg;
    $Code =~ s{61352\s+Bad\s+Homburg}{61440 Oberursel}smxg;

    return $Code;
}

1;
