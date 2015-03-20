#!/usr/bin/perl
 
use local::lib;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Modern::Perl;
use Test::More;
use Moops;
use DBIx::Class;
use TicTacToe;
use TicTacToe::Schema;

#build an in memory SQLite db from our DBIx Schema
my $schema = TicTacToe::Schema->connect('dbi:SQLite::memory:');
$schema->deploy;


my $game = TicTacToe->new({ schema => $schema });
$game->newgame;
is($game->game_id,1,'Created new game');
$game->move(1);
is($game->message,'No winner yet','Basic Move');
$game->move(1);
is($game->message,'Move already taken','Duplicate Move');
$game->move(10);
is($game->message,'Invalid Move','Out of Range Move (High)');
$game->move(-1);
is($game->message,'Invalid Move','Out of Range Move (Low)');
$game->move(4); # O
$game->move(2); # X
$game->move(5); # O
$game->move(3); # X
is($game->message,'Player: 0 wins','Basic position 123 win');
done_testing();