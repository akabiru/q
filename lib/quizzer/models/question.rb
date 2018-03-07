module Quizzer
  module Models
    class Question
      @@questions ||= []

      attr_reader :id, :difficulty, :fk_id

      def initialize(arr, fk_id)
        @id = arr[0]
        @difficulty = arr[1]
        @fk_id = fk_id

        push_to_questions_list
      end

      class << self
        def self_list
          @@questions
        end

        def fk_objects(parent_id)
          self_list.select { |o| o.fk_id == parent_id }
        end

        def find_or_create(q_arr, fk_id)
          id = q_arr[0]
          obj_exists = self_list.find { |q| q.id == id }

          # we do not have an existing question; so create one
          new(q_arr, fk_id) unless obj_exists
        end
      end

      private

      def push_to_questions_list
        @@questions.push self
      end
    end
  end
end
