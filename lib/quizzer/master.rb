require 'csv'
require_relative 'orm/strand'
require_relative 'orm/standard'
require_relative 'orm/question'

module Quizzer
  class Master
    attr_reader :strands

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
      p arr_of_arrs[1..-1]
      @strands = load_orm_objects(arr_of_arrs[1..-1])
    end

    def load_orm_objects(data)
      data.map do |arr|
        Orm::Strand.find_or_create(arr)
      end
    end

    def cycle_through_strands(strands)
      pick_random_standards
    end

    def pick_random_standards
      pick_random_questions
    end

    def pick_random_questions
    end

    def questions_csv_path
      File.join(File.dirname(__FILE__), '..', '..', 'questions.csv')
    end
  end
end
