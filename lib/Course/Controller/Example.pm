package Course::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub get_course {
  my $self = shift;
  my $name = $self->param('name');
  $self->res->headers->cache_control('max-age=1, no-cache');
  $self->render(json => {hello => $name});
}

sub graphql_query {
	my $self = shift;
	$self->render('example/query', msg => 'GraphQl query!');
}

sub show {
	my $self = shift;
	my $page = $self->param('name');
	if ($page) {
		$self->render( page => $page );
	}
}

1;
