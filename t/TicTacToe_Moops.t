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
#is($game->move(1),'No winner yet','Basic Move');
#is($game->move(1),'Move already taken','Duplicate Move');
#is($game->move(10),'Invalid Move','Out of Range Move (High)');
#is($game->move(-1),'Invalid Move','Out of Range Move (Low)');
#$game->move(4); # O
#$game->move(2); # X
#$game->move(5); # O
#is($game->move(3),'Player: 0 wins','Basic position 123 win');
done_testing();