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
    has success => ( is => 'rw', isa => Int);
    has game_id => ( is => 'rw', isa => Int);
    has message => ( is => 'rw', isa => Str);
    
    method newgame () {
        my $game = $self->schema->resultset('Game')->create({});
        if ($game) {
            $self->success(1);
            $self->game_id($game->id);
            $self->message('New game created');
        } else {
            $self->success(0);
            $self->message('Unable to create game');
        }
    }
    
    method move (Int $move) {
        # check move
        
        #save db
        
        #return status
        
    }

}

1;