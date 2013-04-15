class Spree::Ingredient < ActiveRecord::Base
  attr_accessible :name, :unit, :taxon_ids
  validates :name, :unit, presence: true

  has_and_belongs_to_many :taxons, :join_table => 'spree_ingredients_taxons'
end
