#!/usr/bin/perl
 
use strict;
use warnings;

use local::lib;
use Moops;


class TicTacToe {
    has schema => (
        is => 'ro',
        required => 1,
        isa => InstanceOf ['DBIx::Class::Schema'],
    );
    
    method newgame () {
        my $game = $self->schema->resultset('Game')->create({});
        if ($game) {
            return ({ success => \1, game_id => $game->id });
        } else {
            return ({ success => \0, message => 'Unable to create game' });
        }
    }
    
    method move (Int $move) {
        # check move
        
        #save db
        
        #return status
        
    }

}

1;