package Course::Model::DB;

use strict;
use warnings;

use Moose;

has 'c' => (
	is => 'ro',
	isa => 'Course',
	required => 1
);

sub records {
	return {
		a => { id => 'a', name => 'alice' },
		b => { id => 'b', name => 'bob' },
	};
}

1;