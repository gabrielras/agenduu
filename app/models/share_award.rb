class ShareAward < ApplicationRecord
  belongs_to :client
  belongs_to :print_award

  validates :confirmed, inclusion: { in: [ true, false ] }

  before_create :create_unique_key

  private

  def create_unique_key
    loop do
      self.key = SecureRandom.hex(5)
      break unless self.class.exists?(:key => key)
    end
  end
end
