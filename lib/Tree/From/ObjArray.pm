package Tree::From::ObjArray;

# AUTHORITY
# DATE
# DIST
# VERSION

require Code::Includable::Tree::FromObjArray;

use Exporter qw(import);
our @EXPORT_OK = qw(build_tree_from_obj_array);

sub build_tree_from_obj_array {
    my $obj_array = shift;

    Code::Includable::Tree::FromObjArray->new_from_obj_array($obj_array);
}

1;
# ABSTRACT: Build a tree of objects from a nested array of objects

=head1 SYNOPSIS

In your tree node class F<My/Person.pm>:

 package My::Person;

 sub new {
     my $class = shift;
     my %args = @_;
     bless \%args, $class;
 }

 sub parent {
     my $self = shift;
     $self->{_parent} = $_[0] if $@;
     $self->{_parent};
 }

 sub children {
     my $self = shift;
     $self->{_children} = $_[0] if $@;
     $self->{_children};
 }

In your code to build a tree:

 use Tree::From::ObjArray qw(build_tree_from_obj_array);

 # require all the used classes
 use My::Person;
 use My::MarriedPerson;
 use My::KidPerson;

 my $family_tree = build_tree_from_obj_array([
     My::Person->new(name => 'Andi', age => 60), [
       My::Person->new(name => 'Budi', age => 30),
       My::MarriedPerson->new(name => 'Cinta'), [
         My::KidPerson->new(name => 'Deni'),
         My::KidPerson->new(name => 'Eno'),
       ],
    ]
 ]);

This tree is visualized as follows:

 Andi
   ├─Budi
   └─Cinta
       ├─Deni
       └─Eno


=head1 DESCRIPTION

Building a tree manually can be tedious: you have to connect the parent and
the children nodes together:

 my $root = My::TreeNode->new(...);
 my $child1 = My::TreeNode->new(...);
 my $child2 = My::TreeNode->new(...);

 $root->children([$child1, $child2]);
 $child1->parent($root);
 $child2->parent($root);

 my $grandchild1 = My::TreeNode->new(...);
 ...

This module provides a convenience function to build a tree of objects in a
single command. It connects the parent and children nodes for you.

The class can be any class that provides C<parent> and C<children> methods. See
L<Role::TinyCommons::Tree::Node> for more details.


=head1 FUNCTIONS

=head2 build_tree_from_obj_array($obj_array) => obj

This is basically L<Role::TinyCommons::Tree::FromObjArray>'s
C<new_from_obj_array> presented as a function. See the role's documentation for
more details on what you can put in C<$obj_array>.


=head1 SEE ALSO

L<Role::TinyCommons::Tree::FromObjArray> if you want to use this functionality
via consuming a role.

Another way to create tree from a nested hash data structure:
L<Tree::From::Struct>.

Other ways to create tree: L<Tree::From::Text>, L<Tree::From::TextLines>,
L<Tree::Create::Callback>, L<Tree::Create::Size>.
