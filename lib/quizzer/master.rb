require 'csv'

module Quizzer
  class Master

    def initialize(number_of_questions)
      @num_of_q = number_of_questions
    end

    class << self
      def run!(number_of_questions)
        new(number_of_questions).run!
      end
    end

    def run!
      build_orm
    end

    def build_orm
      arr_of_arrs = CSV.read(questions_csv_path)
      p arr_of_arrs
    end

    def questions_csv_path
      File.join(File.dirname(__FILE__), '..', '..', 'questions.csv')
    end
  end
end
