class Tweet < ApplicationRecord
    belongs_to :user

    has_many :tweet_tags
    has_many :tags, through: :tweet_tags

    before_validation :link_check, on: :create

    validates :message, presence: true
    validates :message, length: {maximum: 140, too_long: "Max 140 characters"}, on: :create

    after_validation :apply_link, on: :create

    serialize :link, Array

    private

    def link_check
      if self.message.include?("http://") || self.message.include?("https://")
        truncated_message = self.message.split.map do |word|
          if word.include? "http"
            self.link.push(word)
            "#{word[0..20]}..."
          else
            word
          end
        end
        self.message = truncated_message.join(' ')
      end
    end

    def apply_link
      if self.message.include?("http://") || self.message.include?("https://")
        linked_message = self.message.split.map do |word|
          if word.include? "http"
            "<a href='#{self.link.shift}' target='_blank'>#{word}</a>"
          else
            word
          end
        end
        self.message = linked_message.join(' ')
      end
    end
end
