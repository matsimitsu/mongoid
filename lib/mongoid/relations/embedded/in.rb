# encoding: utf-8
module Mongoid # :nodoc:
  module Relations #:nodoc:
    module Embedded
      class In < Relations::Proxy

        # Instantiate a new embedded_in relation.
        #
        # Options:
        #
        # target: The target [parent document] of the relation.
        # metadata: The relation's metadata
        def initialize(target, metadata)
          init(target, metadata)
        end

        # Substitutes the supplied target documents for the existing document
        # in the relation.
        #
        # Example:
        #
        # <tt>name.substitute(new_name)</tt>
        #
        # Options:
        #
        # target: A document to replace the target.
        #
        # Returns:
        #
        # The relation or nil.
        def substitute(target)
          return nil unless target
          @target = target; self
        end
      end
    end
  end
end
