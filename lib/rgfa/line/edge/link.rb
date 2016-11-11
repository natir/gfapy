# A link connects two segments, or a segment to itself.
class RGFA::Line::Edge::Link < RGFA::Line::Edge

  RECORD_TYPE = :L
  POSFIELDS = [:from, :from_orient, :to, :to_orient, :overlap]
  PREDEFINED_TAGS = [:MQ, :NM, :RC, :FC, :KC]
  FIELD_ALIAS = {}
  DATATYPE = {
     :from => :segment_name_gfa1,
     :from_orient => :orientation,
     :to => :segment_name_gfa1,
     :to_orient => :orientation,
     :overlap => :alignment_gfa1,
     :MQ => :i,
     :NM => :i,
     :RC => :i,
     :FC => :i,
     :KC => :i,
  }
  REFERENCE_FIELDS = [:from, :from_orient, :to, :to_orient, :overlap]
  DEPENDENT_REFERENCES = [:paths]
  NONDEPENDENT_REFERENCES = []

  define_field_methods!

end

require_relative "common/alignment_type"
require_relative "common/from_to"
require_relative "gfa1/to_gfa2"
require_relative "gfa1/references"
require_relative "link/canonical"
require_relative "link/complement"
require_relative "link/equivalence"
require_relative "link/references"

class RGFA::Line::Edge::Link
  include RGFA::Line::Edge::Common::FromTo
  include RGFA::Line::Edge::Common::AlignmentType
  include RGFA::Line::Edge::GFA1::ToGFA2
  include RGFA::Line::Edge::GFA1::References
  include RGFA::Line::Edge::Link::Canonical
  include RGFA::Line::Edge::Link::Complement
  include RGFA::Line::Edge::Link::Equivalence
  include RGFA::Line::Edge::Link::References
end
