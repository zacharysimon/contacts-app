class Contact < ActiveRecord::Base

  belongs_to :user


  def name_in_caps
    first_name.upcase
  end

  def readable_created_at
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japan_number
    "+81 #{phone_number}" 
  end

end
