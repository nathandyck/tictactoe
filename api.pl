#!/usr/bin/perl
use local::lib;
use FindBin;
use lib "$FindBin::Bin/lib";
use Mojolicious::Lite;
use TicTacToe::API; 

# Start the app
my $app = TicTacToe::API->new;
$app->start;