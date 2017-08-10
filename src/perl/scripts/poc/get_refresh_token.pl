#!/usr/bin/env perl

use strict;
use warnings;
use 5.010_000;
use utf8;
binmode STDOUT, ":encoding(utf8)";

use Text::CSV_XS;
use FindBin;
use lib $FindBin::Bin . '/../lib';
use Net::Google::Spreadsheets::V4;

use Net::Google::DataAPI::Auth::OAuth2;
 
use lib 'lib';
use Term::Prompt;
use Net::Google::DataAPI::Auth::OAuth2;
use Net::Google::Spreadsheets;
use Data::Printer ; 


my $oauth2 = Net::Google::DataAPI::Auth::OAuth2->new(
    client_id        => $ENV{CLIENT_ID},
    client_secret    => $ENV{CLIENT_SECRET},
    scope            => ['https://www.googleapis.com/auth/spreadsheets'],
);
my $url = $oauth2->authorize_url();
# system("open '$url'");
print "go to the following url with your browser \n" ; 
print "$url\n" ; 


my $code = prompt('x', 'paste code: ', '', '');
my $objToken = $oauth2->get_access_token($code);

my $refresh_token = $objToken->refresh_token() ; 


print "my refresh token is : \n" ; 
p($refresh_token ) ; 
exit ; 
p ( $objToken ) ; 


my $gs = Net::Google::Spreadsheets::V4->new(
      client_id      => $ENV{CLIENT_ID}
    , client_secret  => $ENV{CLIENT_SECRET}
    , refresh_token  => $refresh_token 
    , spreadsheet_id => '1hGNULaWpYwtnMDDPPkZT73zLGDUgv5blwJtK7hAiVIU'
);

my($content, $res);

my $title = 'My foobar sheet';

my $sheet = $gs->get_sheet(title => $title);

# create a sheet if does not exit
unless ($sheet) {
    ($content, $res) = $gs->request(
        POST => ':batchUpdate',
        {
            requests => [
                {
                    addSheet => {
                        properties => {
                            title => $title,
                            index => 0,
                        },
                    },
                },
            ],
        },
    );

    $sheet = $content->{replies}[0]{addSheet};
}

my $sheet_prop = $sheet->{properties};

# clear all cells
$gs->clear_sheet(sheet_id => $sheet_prop->{sheetId});

# import data
my @requests = ();
my $idx = 0;

my @rows = (
    [qw(name age favorite)], # header
    [qw(tarou 31 curry)],
    [qw(jirou 18 gyoza)],
    [qw(saburou 27 ramen)],
);

for my $row (@rows) {
    push @requests, {
        pasteData => {
            coordinate => {
                sheetId     => $sheet_prop->{sheetId},
                rowIndex    => $idx++,
                columnIndex => 0,
            },
            data => $gs->to_csv(@$row),
            type => 'PASTE_NORMAL',
            delimiter => ',',
        },
    };
}

# format a header row
push @requests, {
    repeatCell => {
        range => {
            sheetId       => $sheet_prop->{sheetId},
            startRowIndex => 0,
            endRowIndex   => 1,
        },
        cell => {
            userEnteredFormat => {
                backgroundColor => {
                    red   => 0.0,
                    green => 0.0,
                    blue  => 0.0,
                },
                horizontalAlignment => 'CENTER',
                textFormat => {
                    foregroundColor => {
                        red   => 1.0,
                        green => 1.0,
                        blue  => 1.0
                    },
                    bold => \1,
                },
            },
        },
        fields => 'userEnteredFormat(backgroundColor,textFormat,horizontalAlignment)',
    },
};

($content, $res) = $gs->request(
    POST => ':batchUpdate',
    {
        requests => \@requests,
    },
);

exit;

#Google Sheets API, v4

# Scopes
# https://www.googleapis.com/auth/drive	View and manage the files in your Google D# # i# rive
# https://www.googleapis.com/auth/drive.file	View and manage Google Drive files and folders that you have opened or created with this app
# https://www.googleapis.com/auth/drive.readonly	View the files in your Google Drive
# https://www.googleapis.com/auth/spreadsheets	View and manage your spreadsheets in Google Drive
# https://www.googleapis.com/auth/spreadsheets.readonly	View your Google Spreadsheets

