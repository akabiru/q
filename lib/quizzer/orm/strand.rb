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

          s_exists = @@strands.select do |s|
            s.id == strand_id
          end

          # we do not have an existing strand
          return new(arr) unless s_exists

          # we have an existing strand; create standards in it
          s_exists.push_standards(arr[2..-1])
        end
      end

      def push_standards(std_array)
        @standard = Orm::Standard.find_or_create(std_array, @id)
      end

      private

      def push_to_strands_list
        @@strands.push self
      end
    end
  end
end
