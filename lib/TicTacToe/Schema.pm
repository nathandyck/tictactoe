package TicTacToe::Schema;

use strict;
use warnings;
use local::lib;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces();

1;