class Product < ActiveRecord::Base
    has_attached_file :image, :styles=> {:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/noimg.jpg"
    
    validates_attachment :image, :content_type => {:content_type => ["image/jpeg", "image/png", "image/gif"]}



    def age_range
        if self.maximum_age_appropriate.nil? 
            return "0 and above" if self.minimum_age_appropriate.nil?
            return "#{self.minimum_age_appropriate} and above"
        elsif self.maximum_age_appropriate == self.minimum_age_appropriate
            return "Age #{self.maximum_age_appropriate}"
        else
            return "#{self.minimum_age_appropriate} to #{self.maximum_age_appropriate}"
        end
    end 
         
    def age_appropriate?(age)
        max = 200
        min = 0
        max = self.maximum_age_appropriate unless self.maximum_age_appropriate.nil?
        min = self.minimum_age_appropriate unless self.minimum_age_appropriate.nil?
        return (age >= min and age <= max)
    end

    def self.sorted_by(field)
        return Product.order("name") unless Product.column_names.include?(field)
        return Product.order(field)
    end

    def self.filter_by(age="", price="")
        age = "" if age.nil?
        price = "" if price.nil?
        #puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #{age}"
        #puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #{price}"
        return Product.all if age.empty? and price.empty?
        return Product.where("minimum_age_appropriate <= #{age}").where("maximum_age_appropriate >= #{age} OR maximum_age_appropriate IS NULL") if age.empty? == false and price.empty?
        return Product.where("price <= #{price}") if age.empty? and price.empty? == false
        return Product.where("minimum_age_appropriate <= #{age}").where("maximum_age_appropriate >= #{age}").where("price <= #{price}") unless age.empty? and price.empty?
    end
end
