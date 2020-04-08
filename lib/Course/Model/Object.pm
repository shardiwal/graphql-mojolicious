package Course::Model::Object;

use strict;
use warnings;

use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw($String);

use Moose;

has 'c' => (
	is => 'ro',
	isa => 'Course',
	required => 1
);

has 'user' => (
	is => 'ro',
	isa => 'GraphQL::Type::Object',
	lazy_build => 1
);
sub _build_user {
	return GraphQL::Type::Object->new(
		name => 'User',
		fields => {
			id => { type => $String },
			name => { type => $String },
		},
	);
}

1;