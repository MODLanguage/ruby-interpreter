module Modl::Parser
  class ThrowingErrorListener
    include Singleton

    def syntax_error(_recognizer, _offending_symbol, _line, _char_position_in_line, _msg, _e)
      raise ParseCancellationException, 'line' + _line.to_s + ':' + _char_position_in_line.to_s + ' ' + _msg.to_s
    end

    def report_ambiguity(_recognizer, _dfa, _start_index, _stop_index, _exact, _ambig_ilts, _configs)
    end

    def report_attempting_full_context(_recognizer, _dfa, _start_index, _stop_index, _conflicting_alts, _configs)
    end

    def report_context_sensitivity(_recognizer, _dfa, _start_index, _stop_index, _prediction, _configs)
    end
  end
end