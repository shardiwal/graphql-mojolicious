package Course::Model::Schema;

use strict;
use warnings;

use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw($String);

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
			fields => $self->schema_fields(),
		)
	);
}

sub schema_fields {
	my ( $self ) = @_;
	return {
		user => $self->schema_fields_user
	};
}

sub schema_fields_user {
	my ( $self ) = @_;
	my $c = $self->c;
	return {
		type => $c->object->user,
		args => { id => { type => $String } },
		resolve => sub {
			my ($root_value, $args) = @_;
			my $id = $args->{id};
			return unless $c->db->records->{$id};
			$c->db->records->{$id}
		},
	};
}

1;