package TidyAll::Plugin::OTRS::Legal::ReplaceCopyright;

use strict;
use warnings;

use File::Basename;
use File::Copy qw(copy);
use base qw(TidyAll::Plugin::OTRS::Base);

sub transform_source {
    my ( $Self, $Code ) = @_;

    return $Code if $Self->is_disabled(Code => $Code);

    my $Copy = 'OTRS AG, http://otrs.com/';
    my $StartYear = 2001;

    my ( $Sec, $Min, $Hour, $Day, $Month, $Year ) = localtime(time());
    $Year += 1900;

    my $YearString = "$StartYear-$Year";
    if ($StartYear == $Year) {
        $YearString = $Year;
    }

    my $Output;

    LINE:
    for my $Line ( split(/\n/, $Code) ) {
        if ($Line !~ m{Copyright}smx) {
            $Output .= $Line . "\n";
            next LINE;
        }

        my $OldLine = $Line;

        # special settings for the language directory
        if ($Line !~ m{OTRS}smx && $Code =~ m{ package \s+ Kernel::Language:: }smx ) {
            $Output .= $Line . "\n";
            next LINE;
        }

        # for the commandline help
        # e.g : print "Copyright (c) 2003-2008 OTRS AG, http://www.otrs.com/\n";
        if ($Line !~ m{^\# \s Copyright}smx) {
            if ($Line =~ m{^ (.+?) Copyright \s \( [Cc] \) .+? OTRS \s (AG|GmbH), \s http://otrs.(?:org|com)/}smx) {
                 $Line =~ s{
                     ^ (.+?) Copyright \s \( [Cc] \) .+? OTRS \s (AG|GmbH), \s http://otrs.(?:org|com)/
                 }
                 {$1Copyright (C) $YearString $Copy}smx;

                 if ( $Line ne $OldLine) {
                     print "ReplaceCopyright: Old: $OldLine\n";
                     print "ReplaceCopyright: New: $Line\n";
                 }
            }
            $Output .= $Line . "\n";
            next LINE;
        }

        # check string in the comment line
        if ($Line !~ m{^\# \s Copyright \s \( [Cc] \) \s $YearString \s $Copy$}smx ) {
            $Line = "# Copyright (C) $YearString $Copy";

             if ( $Line ne $OldLine) {
                 print "ReplaceCopyright: Old: $OldLine\n";
                 print "ReplaceCopyright: New: $Line\n";
             }
        }

        $Output .= $Line . "\n";
    }

    return $Output;
}

1;
