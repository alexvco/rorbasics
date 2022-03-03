# NOTE: this is to allow inheritance
RuboCop::Cop::Style::ClassAndModuleChildren.instance_variable_set(
  :@registry,
  RuboCop::Cop::Cop.registry
)

class RuboCop::Cop::Style::ClassAndModuleChildrenNested < RuboCop::Cop::Style::ClassAndModuleChildren
end