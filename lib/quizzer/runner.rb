require 'csv'
require_relative 'models/strand'
require_relative 'models/standard'
require_relative 'models/question'

module Quizzer
  class Runner
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
      build_orm_models
      load_children

      output_data = ['question_id', *random_questions]

      write_to_csv(output_data)
      puts output_data
      exit 0
    end

    def build_orm_models
      arr_of_arrs = CSV.read(questions_csv_path)
      @strands = load_model_objects(arr_of_arrs[1..-1])
    end

    def load_model_objects(data)
      data.each { |arr| Models::Strand.find_or_create(arr) }
      Models::Strand.self_list
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
        standard = Models::Standard.fk_objects(strand.id).sample
        question = Models::Question.fk_objects(standard.id).sample

        q_ids << question.id if question
      end
      q_ids
    end

    def write_to_csv(data, filename = 'usage')
      CSV.open("#{filename}.csv", 'wb') { |csv| csv << data }
    end

    def questions_csv_path
      File.join(File.dirname(__FILE__), '..', '..', 'questions.csv')
    end
  end
end
