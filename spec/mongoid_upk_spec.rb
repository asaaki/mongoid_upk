# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "digest/sha1"
require "digest/md5"

class TestDoc
  include Mongoid::Document
  include Mongoid::UPK
  uuid_pk

  field :name
end

describe Mongoid::UPK do
  it "automatic uuid generator" do
    td = TestDoc.new
    old_id = td._id
    td.save and td.reload
    td._id.should_not == old_id
  end

  it "bson id + uuid" do
    class TestDoc2 < TestDoc
      include Mongoid::Document
      include Mongoid::UPK
      bson_uuid_pk
    end

    td = TestDoc2.new
    old_id = td._id
    td.save and td.reload
    td._id.should_not == old_id
    td._id.should     =~ /#{old_id}/
  end

  it "raises error if dependency not met" do
    expect {
      class FailTest
        include Mongoid::UPK
      end
    }.to raise_error(Mongoid::UPK::MissingDependency)
  end

  it "#unique_pk with block" do
    class TestDoc3
      include Mongoid::Document
      include Mongoid::UPK
      unique_pk do
        "md5-" + Digest::MD5.hexdigest(Time.now.to_f.to_s)
      end
    end

    td = TestDoc3.new
    old_id = td._id
    td.save and td.reload
    td._id.should_not == old_id
  end

end
