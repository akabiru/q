require_relative 'quizzer/runner'

module Quizzer
  class CliController
    class << self
      def call(args)
        num_of_q = validate_input(args)
        Quizzer::Runner.run!(num_of_q)
      end

      private_class_method

      def validate_input(input)
        num = input.first.to_i
        num <= 0 ? print_error_msg : num
      end

      def print_error_msg
        puts "Error: num too low; please choose a number greater than 0."
        exit 1
      end
    end
  end
end
