package ACPM_www;
use Mojo::Base 'Mojolicious';
use ACPM_www::Links;
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
  $self->plugin('PODRenderer');

  $self->plugins->add_hook(before_render => sub {
	my $self = shift;
	my $stash = shift;

	$stash->{links} = ACPM_www::Links::links();
  });

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/welcome')->to('example#welcome');
  
  $r->route('/')->to( cb => sub { shift->render( template => 'index') } );
}

1;
