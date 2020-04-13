package Course::Model::DB;

use strict;
use warnings;

use Moose;

has 'c' => (
	is => 'ro',
	isa => 'Course',
	required => 1
);

has 'users' => (
	is      => 'rw',
	isa     => 'ArrayRef',
	traits  => ['Array'],
	handles => {
		all_users   => 'elements',
		add_user    => 'push',
		count_user  => 'count',
		filter_user => 'grep',
	},
	lazy_build => 1,
);

sub _build_users {
	return [
		{ id => 'a', name => 'alice' },
		{ id => 'b', name => 'bob' }
	];	
}

has 'courses' => (
	is      => 'rw',
	isa     => 'ArrayRef',
	traits  => ['Array'],
	handles => {
		all_courses   => 'elements',
		add_course    => 'push',
		count_course  => 'count',
		filter_course => 'grep',
	},
	lazy_build => 1,
);

sub _build_courses {
	my ( $self ) = @_;
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