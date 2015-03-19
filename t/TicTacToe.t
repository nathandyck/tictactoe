#!/usr/bin/perl
 
use local::lib;
use Modern::Perl;
use Test::More;
use lib "lib";  #TODO: need a better directory agnostic way
use lib "../lib";  #TODO: need a better directory agnostic way

require_ok('TicTacToe');
require_ok('TicTacToe::Schema');


#build an in memory SQLite db from our DBIx Schema
my $schema = TicTacToe::Schema->connect('dbi:SQLite::memory:');
$schema->deploy;


my $game = $schema->resultset('Game')->create({
    player1 => 'Test',
    player2 => 'asdfasf',
});
is($game->id,1,'Created new game');
is($game->move(0,1),'No winner yet','Basic Move');
is($game->move(0,1),'Move already taken','Duplicate Move');
is($game->move(0,10),'Invalid Move','Out of Range Move (High)');
is($game->move(0,-1),'Invalid Move','Out of Range Move (Low)');
$game->move(0,2);
is($game->move(0,3),'Player: 0 wins','Basic position 123 win');


done_testing();