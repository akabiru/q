require 'csv'
require_relative 'orm/strand'
require_relative 'orm/standard'
require_relative 'orm/question'

module Quizzer
  class Master
    attr_reader :strands, :children, :num_of_q

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
      load_children

      puts random_questions
      exit 0
    end

    def build_orm
      arr_of_arrs = CSV.read(questions_csv_path)
      @strands = load_orm_objects(arr_of_arrs[1..-1])
    end

    def load_orm_objects(data)
      data.each { |arr| Orm::Strand.find_or_create(arr) }
      Orm::Strand.self_list
    end

    def load_children
      @children = strands.map do |strand|
        strand.children.map { |child| child.fk_objects(strand.id) }.flatten
      end
    end

    def random_questions
      q_ids = []
      num_of_q.to_i.times do
        strand = strands.sample
        standard = Orm::Standard.fk_objects(strand.id).sample
        question = Orm::Question.fk_objects(standard.id).sample

        q_ids << question.id if question
      end
      q_ids
    end

    def questions_csv_path
      File.join(File.dirname(__FILE__), '..', '..', 'questions.csv')
    end
  end
end
