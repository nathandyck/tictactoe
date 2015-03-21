package TicTacToe::API;

use local::lib;
use Modern::Perl;
use Mojo::Base 'Mojolicious';
use Mojolicious::Lite;
use lib '..';
use TicTacToe::Schema;


# Global handle for schema connection
my $schema = "";

# Create Schema as needed
helper schema => sub {
    if ($schema) {
        return $schema;
    } else {
        #build an in memory SQLite db from our DBIx Schema
        $schema = TicTacToe::Schema->connect('dbi:SQLite::memory:');
        $schema->deploy;
        return $schema;
    }
};

get '/' => sub {
  my $c = shift;
  $c->render(text => 'TicTacToe API Example');
};

get '/api/newgame' => sub {
    my $self = shift;
    
    my $game = $self->schema->resultset('Game')->create({});
    if ($game) {
        return $self->render(json => { success => \1, game_id => $game->id});
    } else {
        return $self->render(json => { success => \0, message => 'Unable to create game'});
    }
};

get '/api/move/:game_id/:move' => sub {
    my $self = shift;
    my $game_id  = $self->stash('game_id');
    my $move  = $self->stash('move');
    
    my $game = $self->schema->resultset('Game')->find($game_id);
    
    my $success;
    my $results;
    if ($game) {
        $results = $game->move($move);
        if (
            ($results eq 'No winner yet') ||
            ($results =~ /^Player: [0..1] wins$/) ||
            ($results eq 'Board is full with no winner. Cat\'s game.')
        ) {
            $success = \1;
        } else {
            $success = \0;
        }
        
        return $self->render(json => { success => $success, message => $results, game_id => $game->id });
    } else {
        return $self->render(json => { success => \0, message => "Invalid game_id: $game_id" });
    }
};