require_relative 'question'

module Quizzer
  module Orm
    class Standard
      # keep track of all standards
      @@standards ||= []

      attr_reader :id, :name, :fk_id

      def initialize(arr, fk_id)
        @id = arr[0]
        @name = arr[1]
        @fk_id = fk_id

        push_to_standards_list
      end

      class << self
        def self_list
          @@standards
        end

        def fk_objects(parent_id)
          self_list.select { |o| o.fk_id == parent_id }
        end

        def find_or_create(std_arr, fk_id)
          id = std_arr[0]
          obj_exists = self_list.find { |s| s.id == id }

          # we do not have an existing standard; so create one
          obj = (obj_exists ? obj_exists : new(std_arr, fk_id))
          # we have an existing standard; create child
          obj.find_or_create_child(std_arr[2..-1], obj.id)
        end
      end

      def find_or_create_child(q_arr, fk_id, child = Question)
        child.find_or_create(q_arr, fk_id)
      end

      private

      def push_to_standards_list
        @@standards.push self
      end
    end
  end
end
