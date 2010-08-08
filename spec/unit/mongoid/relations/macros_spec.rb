require "spec_helper"

describe Mongoid::Relations::Macros do

  let(:klass) do
    Class.new do
      include Mongoid::Relations::Macros
      def self.name
        "TestClass"
      end
    end
  end

  describe "#embedded?" do

    context "when the class is embedded" do

      before do
        klass.embedded_in(:person)
      end

      it "returns true" do
        klass.allocate.should be_embedded
      end
    end

    context "when the class is not embedded" do

      it "returns false" do
        klass.allocate.should_not be_embedded
      end
    end
  end

  describe ".embedded?" do

    context "when the class is embedded" do

      before do
        klass.embedded_in(:person)
      end

      it "returns true" do
        klass.should be_embedded
      end
    end

    context "when the class is not embedded" do

      it "returns false" do
        klass.should_not be_embedded
      end
    end
  end

  describe ".embedded_in" do

    it "defines the macro" do
      klass.should respond_to(:embedded_in)
    end

    context "when defining the relation" do

      before do
        klass.embedded_in(:person)
      end

      it "adds the metadata to the klass" do
        klass.relations["person"].should_not be_nil
      end

      it "marks the class as embedded" do
        klass.embedded.should == true
      end

      context "metadata properties" do

        let(:metadata) do
          klass.relations["person"]
        end

        it "automatically adds the name" do
          metadata.name.should == :person
        end

        it "automatically adds the inverse class name" do
          metadata.inverse_class_name.should == "TestClass"
        end
      end
    end
  end

  describe ".embeds_many" do

    it "defines the macro" do
      klass.should respond_to(:embeds_many)
    end

    context "when defining the relation" do

      before do
        klass.embeds_many(:addresses)
      end

      it "adds the metadata to the klass" do
        klass.relations["addresses"].should_not be_nil
      end

      context "metadata properties" do

        let(:metadata) do
          klass.relations["addresses"]
        end

        it "automatically adds the name" do
          metadata.name.should == :addresses
        end

        it "automatically adds the inverse class name" do
          metadata.inverse_class_name.should == "TestClass"
        end
      end
    end
  end

  describe ".embeds_one" do

    it "defines the macro" do
      klass.should respond_to(:embeds_one)
    end

    context "when defining the relation" do

      before do
        klass.embeds_one(:name)
      end

      it "adds the metadata to the klass" do
        klass.relations["name"].should_not be_nil
      end

      context "metadata properties" do

        let(:metadata) do
          klass.relations["name"]
        end

        it "automatically adds the name" do
          metadata.name.should == :name
        end

        it "automatically adds the inverse class name" do
          metadata.inverse_class_name.should == "TestClass"
        end
      end
    end
  end

  describe ".referenced_in" do

    it "defines the macro" do
      klass.should respond_to(:referenced_in)
    end
  end

  describe ".references_many" do

    it "defines the macro" do
      klass.should respond_to(:references_many)
    end
  end

  describe ".references_one" do

    it "defines the macro" do
      klass.should respond_to(:references_one)
    end
  end

  describe "#relations" do

    before do
      klass.embeds_one(:name)
    end

    it "returns a hash of relations" do
      klass.allocate.relations.should be_a_kind_of(Hash)
    end

    it "has keys that are the relation name" do
      klass.allocate.relations.keys.first.should == "name"
    end

    it "has values that are metadata" do
      klass.allocate.relations.values.first.should
        be_a_kind_of(Mongoid::Relations::Metadata)
    end
  end

  describe ".relations" do

    before do
      klass.embeds_one(:name)
    end

    it "returns a hash of relations" do
      klass.relations.should be_a_kind_of(Hash)
    end

    it "has keys that are the relation name" do
      klass.relations.keys.first.should == "name"
    end

    it "has values that are metadata" do
      klass.relations.values.first.should
        be_a_kind_of(Mongoid::Relations::Metadata)
    end
  end
end
