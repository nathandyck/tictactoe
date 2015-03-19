#!/usr/bin/perl
use local::lib;
use Mojolicious::Lite;
use Mojo::JSON;
use DBIx::Class;
use lib 'lib';
use TicTacToe;
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

get '/api/v1/newgame' => sub {
    my $self = shift;
    
    my $game = $self->schema->resultset('Game')->create({});
    
    return $self->render(json => {game_id => $game->id});
};

get '/api/v1/move/:game_id/:player/:move' => sub {
    my $self = shift;
    my $game_id  = $self->stash('game_id');
    my $player  = $self->stash('player');
    my $move  = $self->stash('move');
    
    my $game = $self->schema->resultset('Game')->find($game_id);
    
    if ($game) {
        my $results = $game->move($player,$move);
        
        # TODO: return stuff
        
        return $self->render(json => { success => $game->id });
    } else {
        $self->render(json => { error => 'Invalid game_id' });
    }
};


# Start the app
app->start;