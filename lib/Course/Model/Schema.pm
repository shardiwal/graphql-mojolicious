package Course::Model::Schema;

use strict;
use warnings;

use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw($String);
use GraphQL::Type::List;

use Moose;

has 'c' => (
	is => 'ro',
	isa => 'Course',
	required => 1
);

has 'default' => (
	is => 'ro',
	isa => 'GraphQL::Schema',
	lazy_build => 1
);
sub _build_default {
	my ( $self ) = @_;
	return GraphQL::Schema->new(
		query => GraphQL::Type::Object->new(
			name => 'Query',
			description => 'Root Query',
			fields => $self->schema_fields(),
		)
	);
}

sub schema_fields {
	my ( $self ) = @_;
	my $c = $self->c;
	return {
		courses => {
			type => GraphQL::Type::List->new( of => $c->object->course ),
			description => 'List of all courses',
			resolve => sub {
				$c->db->courses;
			}
		},
		course => {
			type 		=> $c->object->course('Single_Course'),
			description => 'Single course',
			args        => {
				id => { type => $String }
			},
			resolve     => sub {
				my ($course, $args) = @_;
				my @filtered = grep { $_->{'id'} eq $args->{'id'} } @{$c->db->courses};
				return $filtered[0];
			}
		},
		users => {
			type => GraphQL::Type::List->new( of => $c->object->user ),
			description => 'List of all users',
			resolve => sub {
				$c->db->users;
			}
		},
	};
}



1;