#!/usr/bin/perl
 
use local::lib;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Modern::Perl;
use Test::More;
use Test::Mojo;
use TicTacToe::API;

my $t = Test::Mojo->new('TicTacToe::API');

# create a new game
$t->get_ok('/api/newgame')
  ->status_is(200)
  ->json_is('/success' => 1)
  ->json_is('/game_id' => 1);

# basic move on game 1 to position 5
$t->get_ok('/api/move/1/5')
  ->status_is(200)
  ->json_is('/success' => 1)
  ->json_is('/message' => 'No winner yet');

done_testing();