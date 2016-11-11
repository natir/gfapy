RGFA::Alignment ||= Module.new

# Array of trace points.
#
# A trace is a list of integers, each giving the number of characters
# in the second segment to align to the next TS characters in the first
# segment.
#
# TS is either the default spacing given in the header line TS tag,
# or the the spacing given in the TS tag on the line of the edge.
#
# Note: a complement operation such as for CIGARs cannot be defined
# for a trace, without computing the alignment.
#
class RGFA::Alignment::Trace < Array

  # Validate the numeric array
  #
  # @param ts [Integer,nil] <it>(defaults to: +nil+)<it> trace spacing; if an
  #   integer is specified, it will be checked that all values are < +ts+; if
  #   +nil+, then this check is skipped
  #
  # @raise [RGFA::TypeError] if the array contains non-integer values
  # @raise [RGFA::ValueError] if the array contains values < 0 or > +ts+
  #
  # @return [void]
  #
  def validate!(ts: nil)
    each do |e|
      if !e.kind_of?(Integer)
        raise RGFA::TypeError,
          "Trace contains non-integer values (#{e} found)\n"+
          "Content: #{inspect}"
      end
      if e < 0
        raise RGFA::ValueError,
          "Trace contains value < 0 (#{e} found)\n"+
          "Content: #{inspect}"
      end
      if !ts.nil? and e > ts
        raise RGFA::ValueError,
          "Trace contains value > TS (#{e} found, TS=#{ts})\n"+
        "Content: #{inspect}"
      end
    end
  end

  def to_s
    each(&:to_s).join(",")
  end

  def self.from_string(str)
    RGFA::Alignment::Trace.new(str.split(",").map{|i|Integer(i)})
  end

  # @return [RGFA::Alignment::Trace] self
  def to_trace
    self
  end

  # @param allow_traces [Boolean] ignored, for compatibility only
  # @return [RGFA::Alignment::Trace] self
  def to_alignment(allow_traces = true)
    self
  end

end

class String
  # Parse trace string
  # @return [RGFA::Alignment::Trace]
  # @raise [RGFA::Alignment::Trace::TypeError] if the string is not a valid trace string
  def to_trace
    RGFA::Alignment::Trace.from_string(self)
  end
end