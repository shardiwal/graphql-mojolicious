package Course::Model::DB;

use strict;
use warnings;

use Moose;

has 'c' => (
	is => 'ro',
	isa => 'Course',
	required => 1
);

sub users {
	return [
		{ id => 'a', name => 'alice' },
		{ id => 'b', name => 'bob' }
	];
}

sub courses {
	return [
		{
			body => 'course 1',
			id => '1',
			name => 'Course Hindi',
			user_id => 'a'
		},
		{
			body => 'course 2',
			id => '2',
			name => 'Course English',
			user_id => 'b'
		},
	];
}

1;