module Quizzer
  module Orm
    class Standard
      # keep track of all standards
      @@standards ||= []

      def initialize(arr, fk_id)
        @id = arr[0]
        @name = arr[1]
        @strand_id = fk_id
        @question = Orm::Question.new(arr[2..-1], @id)

        push_to_standards_list
      end

      class << self
        def find_or_create(arr, fk_id)
          id = arr[0]

          s_exists = @@standards.select do |s|
            s.id == id
          end

          # we do not have an existing standard
          return new(arr) unless s_exists

          # we have an existing standard; create questions in it
          s_exists.push(arr[2..-1], id)
        end
      end

      def

      # all questions with
      def questions
      end

      private

      def push_to_standards_list
        @@standards.push self
      end
    end
  end
end
