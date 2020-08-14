require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:close_bracket,
:first_bracket,:last_bracket,:matchs,:indish_open,:indish_close
  def initialize
    @file_data = file_data
    @open_bracket = (/{/)
    @close_bracket = (/}/)
    @first_bracket = first_bracket
    @last_bracket = last_bracket
    @matchs = matchs
    @indish_open = indish_open
    @indish_close = indish_close
  end

    def tag_checker
      take_file_data
      bracket_match_keeper
      bracket_splitter
      if matchs.even? && matchs != 0
        prompt_message('passed')
      elsif matchs.odd? == true && matchs != 0
        prompt_message('failed')
        prompt_lint('missing_brackets')
      elsif matchs == 0
        prompt_message('failed')
        prompt_lint('no_brackets')
      elsif first_bracket == ['{'] && last_bracket == ['}'] && matchs.odd?
        prompt_message('failed')
        prompt_lint('missing_brackets')
      end
    end

    def empty_rule_checker
      take_file_data
      string_to_array
      find_bracket_index
      check_fill_or_not
    end
end