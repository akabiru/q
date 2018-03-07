require_relative 'question'

module Quizzer
  module Orm
    class Standard
      # keep track of all standards
      @@standards ||= []

      def initialize(arr, fk_id)
        @id = arr[0]
        @name = arr[1]
        @fk_id = fk_id

        push_to_standards_list
      end

      class << self
        def find_or_create(std_arr, fk_id)
          id = std_arr[0]
          s_exists = @@standards.find { |s| s.id == id }

          # we do not have an existing standard; so create one
          return new(std_arr, fk_id) unless s_exists

          # we have an existing standard; create child
          s_exists.find_or_create_child(std_arr[2..-1], id)
        end

        def find_or_create_child(q_arr, fk_id, child = Question)
          child.find_or_create(q_arr, fk_id)
        end
      end

      private

      def push_to_standards_list
        @@standards.push self
      end
    end
  end
end
