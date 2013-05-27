Spree::User.class_eval do
  attr_accessible :first_name, :last_name, :phone, :health_issues, :fitness_goals, :fitness_routines, :cats_attributes

  has_many :cats
  accepts_nested_attributes_for :cats, allow_destroy: true
  def cats_or_build
    cats.present? || [cats.new]
  end
end
