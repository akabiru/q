module Quizzer
  module Orm
    class Question
      @@questions ||= []

      def initialize(arr, fk_id)
        @id = arr[0]
        @difficulty = arr[1]
        @fk_id = fk_id

        push_to_questions_list
      end

      class << self
        def find_or_create(q_arr, fk_id)
          id = q_arr[0]
          obj_exists = @@questions.find { |q| q.id == id }

          # we do not have an existing question; so create one
          new(q_arr, fk_id) unless obj_exists
        end
      end

      private

      def push_to_questions_array
        @@questions.push self
      end
    end
  end
end
