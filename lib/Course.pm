package Course;
use Mojo::Base 'Mojolicious';

use Course::Model::DB;
use Course::Model::Object;
use Course::Model::Schema;

# This method will run once at server start
sub startup {
	my $self = shift;

	# Load configuration from hash returned by "my_app.conf"
	my $config = $self->plugin('Config');

	# Documentation browser under "/perldoc"
	$self->plugin('PODRenderer') if $config->{perldoc};

	# Helper to lazy initialize and store our model object
	$self->helper( 'db' => sub { return Course::Model::DB->new('c' => $self) });
	$self->helper( 'object' => sub { return Course::Model::Object->new('c' => $self) });

	$self->plugin(GraphQL => {
		schema => Course::Model::Schema->new( 'c' => $self )->default,
		graphiql => 1
	});

	# Routing
	$self->_routes();
}

sub _routes {
	my ( $self ) = @_;
	$self->helper( 'home_page' => sub{ '/home' } );
	# Router
	my $r = $self->routes;
	# Normal route to controller
	$r->any( '/' => sub { my $self = shift; $self->redirect_to( $self->home_page ) });
	$r->any( '/home' )->to('example#welcome');
	$r->any( '/page/:name' )->to('example#show')->name('show_page');
	$r->get( '/get_course' )->to('example#get_course');
	$r->get( '/graphql_query' )->to('example#graphql_query');
	return;
}

1;
