module Quizzer
  module Orm
    class Question
      def initialize(id, difficulty, standard_id)
        @id = id
        @difficulty = difficulty
        @standard_id = standard_id
      end

      # Standard with id @standard_id
      def standard
      end
    end
  end
end
