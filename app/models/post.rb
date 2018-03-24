class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  accepts_nested_attributes_for :categories

  def category_ids=(ids)
    ids.each do |id|
      category = Category.find_or_create_by(id) unless id.nil?
      self.categories << category if !self.categories.include?(category)
    end
  end


  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      if !category_attribute[:name].nil?
        category = Category.find_or_create_by(category_attribute)
        self.post_categories.build(category: category)
        # self.categories << category
      end
    end
  end

end
