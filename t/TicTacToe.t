#!/usr/bin/perl
 
use local::lib;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Modern::Perl;
use Test::More;


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
is($game->move(1),'No winner yet','Basic Move');
is($game->move(1),'Move already taken','Duplicate Move');
is($game->move(10),'Invalid Move','Out of Range Move (High)');
is($game->move(-1),'Invalid Move','Out of Range Move (Low)');
$game->move(4); # O
$game->move(2); # X
$game->move(5); # O
is($game->move(3),'Player: 0 wins','Basic position 123 win');


done_testing();