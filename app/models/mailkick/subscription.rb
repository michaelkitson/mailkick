module Mailkick
  class Subscription < ActiveRecord::Base
    self.table_name = "mailkick_subscriptions"

    belongs_to :subscriber, polymorphic: true

    validates :list, presence: true

    scope :active, -> { where(deleted_at: nil) }
    scope :inactive, -> { where.not(deleted_at: nil) }

    def active?
      !inactive?
    end

    def inactive?
      deleted_at?
    end

    def deactivate
      update(deleted_at: Time.zone.now)
    end

    def deactivate!
      update!(deleted_at: Time.zone.now)
    end

    def self.deactivate_all
      update_all(deleted_at: Time.zone.now)
    end
  end
end
