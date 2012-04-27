class Company < ActiveRecord::Base
  has_many :fundings

  def as_json(options={})
    {:id  => self.id,
     :name => self.name,
      :location => self.location,
      :portfolio => self.portfolio,
      :fundings => self.fundings}
  end
end
