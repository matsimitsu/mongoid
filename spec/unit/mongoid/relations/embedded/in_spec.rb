require "spec_helper"

describe Mongoid::Relations::Embedded::In do

  let(:klass) do
    Mongoid::Relations::Embedded::In
  end

  context "properties" do

    let(:document) do
      stub
    end

    let(:metadata) do
      stub
    end

    let(:relation) do
      klass.new(document, metadata)
    end

    describe "#metadata" do

      it "returns the relation's metadata" do
        relation.metadata.should == metadata
      end
    end

    describe "#target" do

      it "returns the relation's target" do
        relation.target.should == document
      end
    end
  end

  describe "#substitute" do

    let(:document) do
      stub
    end

    let(:metadata) do
      stub
    end

    let(:relation) do
      klass.new(document, metadata)
    end

    context "when the target is nil" do

      it "returns nil" do
        relation.substitute(nil).should be_nil
      end
    end

    context "when the target is not nil" do

      let(:new_doc) do
        stub
      end

      it "replaces the target" do
        relation.substitute(new_doc)
        relation.target.should == new_doc
      end

      it "returns self" do
        relation.substitute(new_doc).should == new_doc
      end
    end
  end
end
