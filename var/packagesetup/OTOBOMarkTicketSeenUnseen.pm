# --
# Copyright (C) 2012-2023 Znuny GmbH, http://znuny.com/
# Copyright (C) 2022-2023 Rother OSS GmbH, http://otobo.de/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::packagesetup::OTOBOMarkTicketSeenUnseen;    ## no critic

use strict;
use warnings;

use utf8;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::OTOBOHelper',
);

use Kernel::System::VariableCheck qw(:all);

=head1 NAME

var::packagesetup::OTOBOMarkTicketSeenUnseen - code to execute during package installation

=head1 SYNOPSIS

All code to execute during package installation

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $CodeObject    = $Kernel::OM->Get('var::packagesetup::OTOBOMarkTicketSeenUnseen');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    my $ConfigObject      = $Kernel::OM->Get('Kernel::Config');
    my $LogObject         = $Kernel::OM->Get('Kernel::System::Log');
    my $OTOBOHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    my $ArticleActions      = $Self->_ArticleActionsGet();
    my $ArticleActionsAdded = $OTOBOHelperObject->_ArticleActionsAdd( %{$ArticleActions} );
    if ( !$ArticleActionsAdded ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => 'Error adding article actions.',
        );
        return;
    }

    return 1;
}

=item CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    return $Self->CodeInstall();
}

=item CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    return $Self->CodeInstall();
}

=item CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    my $LogObject         = $Kernel::OM->Get('Kernel::System::Log');
    my $OTOBOHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    my $ArticleActions        = $Self->_ArticleActionsGet();
    my $ArticleActionsRemoved = $OTOBOHelperObject->_ArticleActionsRemove( %{$ArticleActions} );
    if ( !$ArticleActionsRemoved ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => 'Error removing article actions.',
        );
        return;
    }

    return 1;
}

sub _ArticleActionsGet {
    my ( $Self, %Param ) = @_;

    my $ArticleActions = {
        Internal => [    # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'OTOBOMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
        Phone => [       # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'OTOBOMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
        Email => [       # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'OTOBOMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
        Chat => [        # Channel name (Internal, Phone, Email, Chat or Invalid)
            {
                Key      => 'OTOBOMarkTicketSeenUnseen',
                Module   => 'Kernel::Output::HTML::ArticleAction::MarkArticleSeenUnseen',
                Priority => 10,
            },
        ],
    };

    return $ArticleActions;
}

1;
