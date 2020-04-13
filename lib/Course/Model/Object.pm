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

has 'course_author' => (
	is => 'ro',
	isa => 'GraphQL::Type::Object',
	lazy_build => 1
);
sub _build_course_author {
	my ( $self ) = @_;
	return GraphQL::Type::Object->new(
		name => 'Course_Author',
		description => 'Course author',
		fields => {
			id      => { type => $String },
			name    => { type => $String },
			email   => { type => $String },
		},
	);
}

sub user {
	my ( $self, $name ) = @_;
	my $c = $self->c;
	if ( !$name ) {
		$name = "User";
	}
	return GraphQL::Type::Object->new(
		name => $name,
		description => 'Our user',
		fields => {
			id      => { type => $String },
			name    => { type => $String },
			email   => { type => $String },
		},
	);
}

sub course {
	my ( $self, $name ) = @_;
	my $c = $self->c;
	if ( !$name ) {
		$name = "Course";
	}
	return GraphQL::Type::Object->new(
		name => $name,
		description => 'Our course',
		fields => {
			body   => { type => $String },
			id     => { type => $String },
			name   => { type => $String },
			author => {
				description => 'Course Author',
				type        => $self->user( $name . '_fk' ),
				resolve     => sub {
					my ($course) = @_;
					my @filtered = grep { $_->{'id'} eq $course->{'user_id'} } @{$c->db->users};
					return $filtered[0];
				}
			},
		}
	);
}

1;