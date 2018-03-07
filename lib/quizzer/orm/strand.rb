require_relative 'standard'

module Quizzer
  module Orm
    class Strand
      # keep track of all strands
      @@strands ||= []

      attr_reader :id

      def initialize(arr)
        @id = arr[0]
        @name = arr[1]

        push_to_strands_list
      end

      class << self
        def find_or_create(arr)
          strand_id = arr[0]
          s_exists = @@strands.find { |s| s.id == strand_id }

          # we do not have an existing strand; create one
          return new(arr) unless s_exists

          # we have an existing strand; find_or_create child in it
          s_exists.find_or_create_child(arr[2..-1], self.class.id)
        end

        def find_or_create_child(std_arr, fk_id, child = Standard)
          child.find_or_create(std_arr, fk_id)
        end
      end

      private

      def push_to_strands_list
        @@strands.push self
      end
    end
  end
end
